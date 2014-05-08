# Encoding: utf-8
default['logstash']['indexer']['config_input'] =
[{
  file: {
    type: 'syslog',

    path: %w[/var/log/*.log /var/log/messages /var/log/syslog]
  }
}]

default['logstash']['indexer']['config_output'] =
[{
  elasticsearch: {
    embedded: true
  }
}]

default['logstash']['indexer']['max_heap_size'] = '1024M'
default['logstash']['indexer']['gc_logging'] = false
