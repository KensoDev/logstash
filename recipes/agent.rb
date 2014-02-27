include_recipe 'logstash::default'

logstash = node['logstash']
logstash_user = logstash['user']
logstash_group = logstash['group']
agent = logstash['agent']

file agent['config_file'] do
  content Chef::Logstash::Helpers.string_from_attrs(agent['config_data'])
  owner logstash_user
  group logstash_group
  mode '755'
end

daemon_name = agent[:daemon_name]
log_file = ::File.join(logstash['logdir'], 'agent.log')
jar_path = ::File.join(logstash['libdir'], 'logstash.jar')
jvm_opts = "#{agent['jvm_opts']} -Des.path.home=#{agent['es_path_home']}"
logstash_args = "-f #{agent['config_file']} -l #{log_file}"
sincedb_dir = agent['sincedb_dir']

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

service daemon_name do
  supports start: true, stop: true, restart: true
  action [:enable, :start]
end
