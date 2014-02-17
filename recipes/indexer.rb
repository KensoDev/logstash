# todo
include_recipe 'logstash::default'

logstash = node['logstash']
logstash_user = logstash['user']
logstash_group = logstash['group']
indexer = logstash['indexer']

file indexer['config_file'] do
  content Chef::Logstash::Helpers.string_from_attrs(indexer['config_data'])
  owner logstash_user
  group logstash_group
  mode '755'
end

daemon_name = indexer[:daemon_name]
log_file = ::File.join(logstash['logdir'], 'indexer.log')
jar_path = ::File.join(logstash['libdir'], 'logstash.jar')
jvm_opts = "#{indexer['jvm_opts']} -Des.path.home=#{indexer['es_path_home']}"
logstash_args = "-f #{indexer['config_file']} -l #{log_file}"
sincedb_dir = indexer['sincedb_dir']

template "/etc/init.d/#{daemon_name}" do
  source 'indexer.init.sh.erb'
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
end
