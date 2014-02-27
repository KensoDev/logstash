# Encoding: utf-8
default['logstash']['indexer']['config_data'] = {
  input: {
    file: {
      type: 'syslog',

      path: %w[/var/log/*.log /var/log/messages /var/log/syslog]
    }
  },

  output: {
    elasticsearch: {
      embedded: true
    }
  }
}

default['logstash']['indexer']['jvm_opts'] = '-server -Xms1024M -Xmx1024M'
