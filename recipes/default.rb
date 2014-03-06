logstash = node['logstash']
logstash_user = logstash['user']
logstash_group = logstash['group']

lib_dir = logstash['libdir']
full_jar_path = ::File.join(lib_dir, "logstash-#{logstash['version']}.jar")
jar_path = ::File.join(logstash['libdir'], 'logstash.jar')

group logstash_group

user logstash_user do
  gid logstash_group
  system true
  shell '/bin/false'
  supports(manage_home: false)
end

logstash.values_at('basedir', 'logdir', 'libdir', 'confdir').each do |dir|
  directory dir do
    owner logstash_user
    group logstash_group
    mode '755'
    recursive true
    not_if { ::File.directory?(dir) }
  end
end

remote_file full_jar_path do
  owner logstash_user
  group logstash_group
  mode '755'
  source logstash['source_url']
  checksum logstash['checksum']
  action :create_if_missing
end

link jar_path do
  to full_jar_path
  owner logstash_user
  group logstash_group
end

logstash['install_types'].uniq.each do |install_type|
  install_attrs = logstash[install_type]

  unless install_attrs
    Chef::Application.fatal!("No install attributes for #{install_type}!")
  end

  config_file = install_attrs['config_file'] ||
    ::File.join(logstash['confdir'], "#{install_type}.conf")
  log_file = install_attrs['log_file'] ||
    ::File.join(logstash['logdir'], "#{install_type}.log")

  daemon_name = install_attrs['daemon_name'] || "logstash-#{install_type}"
  service_resource = "service[#{daemon_name}]"
  jvm_opts = "#{install_attrs['jvm_opts']} -Des.path.home=#{logstash['es_path_home']}"
  logstash_args = "-f #{config_file} -l #{log_file} " + install_attrs['logstash_args'].to_s
  sincedb_dir = logstash['sincedb_dir']

  file config_file do
    content Logstash::Helpers.file_from_config(
              *install_attrs.values_at('config_input', 'config_filter', 'config_output'))
    owner logstash_user
    group logstash_group
    mode '755'
    notifies :restart, service_resource
  end

  template "/etc/init.d/#{daemon_name}" do
    source 'logstash.init.sh.erb'
    owner  'root'
    group  'root'
    mode   '755'
    variables({
      daemon_name: daemon_name,
      user: logstash_user,
      jvm_opts: jvm_opts,
      jar_path: jar_path,
      logstash_args: logstash_args,
      sincedb_dir: sincedb_dir
    })
    notifies :restart, service_resource
  end

  service daemon_name do
    supports start: true, stop: true, restart: true
    action [:enable, :start]
  end
end
