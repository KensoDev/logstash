# Encoding: utf-8
default['logstash']['agent']['config_input'] =
[{
  file: {
    type: 'syslog',

    path: %w[/var/log/*.log /var/log/messages /var/log/syslog]
  }
}]

default['logstash']['agent']['config_output'] =
[{
  file: {
    path: ::File.join(node['logstash']['logdir'], 'out.log')
  }
}]

default['logstash']['agent']['max_heap_size'] = '384M'
default['logstash']['agent']['gc_logging'] = false
