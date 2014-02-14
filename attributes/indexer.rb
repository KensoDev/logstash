# Encoding: utf-8
default['logstash']['indexer']['log_file'] = ::File.join(node['logstash']['logdir'], 'indexer.log')

default['logstash']['indexer']['source_url'] = node['logstash']['source_url']
default['logstash']['indexer']['checksum'] = node['logstash']['source_url']

default['logstash']['indexer']['patterns_dir'] = 'etc/patterns'
default['logstash']['indexer']['config_dir'] = 'etc/conf.d'
default['logstash']['indexer']['config_file'] = 'logstash.conf'
default['logstash']['indexer']['config_templates'] = []
default['logstash']['indexer']['config_templates_cookbook'] = 'logstash'
default['logstash']['indexer']['config_templates_variables'] = {}
default['logstash']['indexer']['base_config'] = 'indexer.conf.erb' # set blank if don't want data driven config
default['logstash']['indexer']['base_config_cookbook'] = 'logstash'
default['logstash']['indexer']['xms'] = '1024M'
default['logstash']['indexer']['xmx'] = '1024M'
default['logstash']['indexer']['java_opts'] = ''
default['logstash']['indexer']['gc_opts'] = '-XX:+UseParallelOldGC'
default['logstash']['indexer']['ipv4_only'] = false
default['logstash']['indexer']['debug'] = false
default['logstash']['indexer']['workers'] = 1

default['logstash']['indexer']['enable_embedded_es'] = true

default['logstash']['indexer']['inputs'] = []
default['logstash']['indexer']['filters'] = []
default['logstash']['indexer']['outputs'] = []

default['logstash']['indexer']['web']['enable']  = false
default['logstash']['indexer']['web']['address'] = '0.0.0.0'
default['logstash']['indexer']['web']['port']    = '9292'
