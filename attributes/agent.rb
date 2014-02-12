# Encoding: utf-8
default[:logstash][:agent][:home] = ::File.join(node[:logstash][:basedir], 'agent')
default[:logstash][:agent][:log_file] = ::File.join(node[:logstash][:logdir], 'agent.log')
default[:logstash][:agent][:source_url] = node[:logstash][:source_url]
default[:logstash][:agent][:checksum] = node[:logstash][:checksum]

default[:logstash][:agent][:patterns_dir] = 'etc/patterns'
default[:logstash][:agent][:config_dir] = 'etc/conf.d'
default[:logstash][:agent][:config_file] = 'logstash.conf'
default[:logstash][:agent][:config_templates] = []
default[:logstash][:agent][:config_templates_cookbook] = 'logstash'
default[:logstash][:agent][:config_templates_variables] = {}
default[:logstash][:agent][:base_config] = 'agent.conf.erb'
default[:logstash][:agent][:base_config_cookbook] = 'logstash'
default[:logstash][:agent][:xms] = '384M'
default[:logstash][:agent][:xmx] = '384M'
default[:logstash][:agent][:java_opts] = ''
default[:logstash][:agent][:gc_opts] = '-XX:+UseParallelOldGC'
default[:logstash][:agent][:ipv4_only] = false
default[:logstash][:agent][:debug] = false

default[:logstash][:agent][:workers] = 1

# roles/flasgs for various autoconfig/discovery components
default[:logstash][:agent][:server_role] = 'logstash_server'
default[:logstash][:agent][:server_ipaddress] = ''

default[:logstash][:agent][:inputs] = []
default[:logstash][:agent][:filters] = []
default[:logstash][:agent][:outputs] = []
