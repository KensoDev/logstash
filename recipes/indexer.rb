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
