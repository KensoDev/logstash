# Encoding: utf-8
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

default['logstash']['agent']['jvm_opts'] =
  '-server -XX:+UseParallelOldGC -Xms384M -Xmx384M'
