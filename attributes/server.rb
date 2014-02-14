# Encoding: utf-8
default['logstash']['server']['home'] = ::File.join(node['logstash']['basedir'], 'server')
default['logstash']['server']['log_file'] = ::File.join(node['logstash']['logdir'], 'server.log')

default['logstash']['server']['source_url'] = node['logstash']['source_url']
default['logstash']['server']['checksum'] = node['logstash']['source_url']

default['logstash']['server']['patterns_dir'] = 'etc/patterns'
default['logstash']['server']['config_dir'] = 'etc/conf.d'
default['logstash']['server']['config_file'] = 'logstash.conf'
default['logstash']['server']['config_templates'] = []
default['logstash']['server']['config_templates_cookbook'] = 'logstash'
default['logstash']['server']['config_templates_variables'] = {}
default['logstash']['server']['base_config'] = 'server.conf.erb' # set blank if don't want data driven config
default['logstash']['server']['base_config_cookbook'] = 'logstash'
default['logstash']['server']['xms'] = '1024M'
default['logstash']['server']['xmx'] = '1024M'
default['logstash']['server']['java_opts'] = ''
default['logstash']['server']['gc_opts'] = '-XX:+UseParallelOldGC'
default['logstash']['server']['ipv4_only'] = false
default['logstash']['server']['debug'] = false
default['logstash']['server']['workers'] = 1

default['logstash']['server']['enable_embedded_es'] = true

default['logstash']['server']['inputs'] = []
default['logstash']['server']['filters'] = []
default['logstash']['server']['outputs'] = []

default['logstash']['server']['web']['enable']  = false
default['logstash']['server']['web']['address'] = '0.0.0.0'
default['logstash']['server']['web']['port']    = '9292'
