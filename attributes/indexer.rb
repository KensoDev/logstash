# Encoding: utf-8
default['logstash']['indexer']['log_file'] = ::File.join(node['logstash']['logdir'], 'indexer.log')

default['logstash']['indexer']['config_file'] = ::File.join(node['logstash']['confdir'], 'indexer.conf')

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
