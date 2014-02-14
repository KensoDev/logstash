logstash = node['logstash']
logstash_user = logstash['user']
logstash_group = logstash['group']
lib_dir = logstash['libdir']
jar_path = ::File.join(lib_dir, "logstash-#{logstash['version']}.jar")

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

remote_file ::File.join(lib_dir, "logstash-#{logstash['version']}.jar") do
  owner logstash_user
  group logstash_group
  mode '755'
  source logstash['source_url']
  checksum logstash['checksum']
  action :create_if_missing
end

link ::File.join(lib_dir, 'logstash.jar') do
  to jar_path
  owner logstash_user
  group logstash_group
end
