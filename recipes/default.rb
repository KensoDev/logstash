logstash = node['logstash']
logstash_user = logstash['user']
logstash_group = logstash['group']

basedir = logstash['basedir']

local_tar_name = 'logstash.tar.gz'
download_tar_path = ::File.join(Chef::Config[:file_cache_path], local_tar_name)

group logstash_group

user logstash_user do
  gid logstash_group
  system true
  shell '/bin/false'
  supports(manage_home: false)
end

logstash.values_at('basedir', 'logdir', 'confdir').each do |dir|
  directory dir do
    owner logstash_user
    group logstash_group
    mode '755'
    recursive true
    not_if { ::File.directory?(dir) }
  end
end

remote_file download_tar_path do
  owner logstash_user
  group logstash_group
  mode '755'
  source logstash['source_url']
  checksum logstash['checksum']
  action :create_if_missing
end

bash 'extract tarball' do
  cwd basedir
  user logstash_user
  group logstash_group

  code "tar xzf #{download_tar_path} --strip-components 1"

  # gotta be a better check for this...
  not_if { ::File.directory?(::File.join(basedir, 'bin')) }
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
  logstash_args = "-f #{config_file} -l #{log_file} " +
    install_attrs['logstash_args'].to_s

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
      basedir: basedir,
      user: logstash_user,
      logstash_args: logstash_args,
      sincedb_dir: logstash['sincedb_dir'],
      max_heap_size: install_attrs['max_heap_size'],
      gc_logging: install_attrs['gc_logging']
    })
    notifies :restart, service_resource
  end

  service daemon_name do
    supports start: true, stop: true, restart: true
    action [:enable, :start]
  end
end
