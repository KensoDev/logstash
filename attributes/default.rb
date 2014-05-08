# Encoding: utf-8
default['logstash']['basedir'] = '/opt/logstash'
default['logstash']['logdir'] = ::File.join(node['logstash']['basedir'], 'log')
default['logstash']['confdir'] = ::File.join(node['logstash']['basedir'], 'conf')

default['logstash']['install_types'] = %w[agent]

default['logstash']['user'] = 'logstash'
default['logstash']['group'] = 'logstash'

default['logstash']['version'] = '1.4.1'
default['logstash']['source_url'] =
  'https://download.elasticsearch.org/logstash/logstash/logstash-1.4.1.tar.gz'
default['logstash']['checksum'] =
  'a1db8eda3d8bf441430066c384578386601ae308ccabf5d723df33cee27304b4'

default['logstash']['sincedb_dir'] = node['logstash']['logdir']
