# Encoding: utf-8
default['logstash']['agent']['log_file'] =
  ::File.join(node['logstash']['logdir'], 'agent.log')

default['logstash']['agent']['config_file'] =
  ::File.join(node['logstash']['confdir'], 'agent.conf')

default['logstash']['agent']['config_data'] = {
  input: {
    file: {
      type: 'syslog',

      path: %w[/var/log/*.log /var/log/messages /var/log/syslog]
    }
  },

  output: {
    file: {
      path: ::File.join(node['logstash']['logdir'], 'out.log')
    }
  }
}

default['logstash']['agent']['daemon_name'] = 'logstash-agent'
default['logstash']['agent']['jvm_opts'] =
  '-server -XX:+UseParallelOldGC -Xms384M -Xmx384M'
default['logstash']['agent']['sincedb_dir'] = node['logstash']['logdir']
