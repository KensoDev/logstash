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

default['logstash']['indexer']['jvm_opts'] = '-server -Xms1024M -Xmx1024M'
