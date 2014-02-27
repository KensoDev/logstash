# Encoding: utf-8
default['logstash']['indexer']['log_file'] =
  ::File.join(node['logstash']['logdir'], 'indexer.log')

default['logstash']['indexer']['config_file'] =
  ::File.join(node['logstash']['confdir'], 'indexer.conf')

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

default['logstash']['indexer']['daemon_name'] = 'logstash-indexer'
default['logstash']['indexer']['jvm_opts'] = '-server -Xms1024M -Xmx1024M'
default['logstash']['indexer']['sincedb_dir'] = node['logstash']['logdir']

# the default config uses embedded es, so we need to put its home path somewhere
# that the logstash user can write...
default['logstash']['indexer']['es_path_home'] = node['logstash']['basedir']
