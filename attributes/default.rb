# Encoding: utf-8
default['logstash']['basedir'] = '/opt/logstash'
default['logstash']['logdir'] = ::File.join(node['logstash']['basedir'], 'log')
default['logstash']['libdir'] = ::File.join(node['logstash']['basedir'], 'lib')
default['logstash']['confdir'] = ::File.join(node['logstash']['basedir'], 'conf')

default['logstash']['install_types'] = %w[agent]

default['logstash']['user'] = 'logstash'
default['logstash']['group'] = 'logstash'

default['logstash']['version'] = '1.3.3'
default['logstash']['source_url'] =
  'https://download.elasticsearch.org/logstash/logstash/logstash-1.3.3-flatjar.jar'
default['logstash']['checksum'] = '6ef146931eb8d4ad3f1b243922626923'

default['logstash']['sincedb_dir'] = node['logstash']['logdir']

# the default config uses embedded es, so we need to put its home path somewhere
# that the logstash user can write...
default['logstash']['es_path_home'] = node['logstash']['basedir']
