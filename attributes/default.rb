# Encoding: utf-8
default['logstash']['basedir'] = '/opt/logstash'
default['logstash']['logdir'] = ::File.join(node['logstash']['basedir'], 'log')
default['logstash']['libdir'] = ::File.join(node['logstash']['basedir'], 'lib')
default['logstash']['confdir'] = ::File.join(node['logstash']['basedir'], 'conf')

default['logstash']['user'] = 'logstash'
default['logstash']['group'] = 'logstash'

default['logstash']['version'] = '1.3.3'
default['logstash']['source_url'] = 'https://download.elasticsearch.org/logstash/logstash/logstash-1.3.3-flatjar.jar'
default['logstash']['checksum'] = '6ef146931eb8d4ad3f1b243922626923'

# roles/flags for various search/discovery
default['logstash']['graphite_role'] = 'graphite_server'
default['logstash']['graphite_query'] = "roles:#{node['logstash']['graphite_role']} AND chef_environment:#{node.chef_environment}"
default['logstash']['graphite_ip'] = ''

default['logstash']['elasticsearch_role'] = 'elasticsearch_server'
default['logstash']['elasticsearch_query'] = "roles:#{node['logstash']['elasticsearch_role']} AND chef_environment:#{node.chef_environment}"
default['logstash']['elasticsearch_cluster'] = 'logstash'
default['logstash']['elasticsearch_ip'] = ''
default['logstash']['elasticsearch_port'] = ''

default['logstash']['patterns'] = {}

