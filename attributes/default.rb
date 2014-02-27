# Encoding: utf-8
default['logstash']['basedir'] = '/opt/logstash'
default['logstash']['logdir'] = ::File.join(node['logstash']['basedir'], 'log')
default['logstash']['libdir'] = ::File.join(node['logstash']['basedir'], 'lib')
default['logstash']['confdir'] = ::File.join(node['logstash']['basedir'], 'conf')

default['logstash']['user'] = 'logstash'
default['logstash']['group'] = 'logstash'

default['logstash']['version'] = '1.3.3'
default['logstash']['source_url'] =
  'https://download.elasticsearch.org/logstash/logstash/logstash-1.3.3-flatjar.jar'
default['logstash']['checksum'] = '6ef146931eb8d4ad3f1b243922626923'


