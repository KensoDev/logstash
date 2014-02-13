logstash = node[:logstash]

group logstash[:group]

user logstash[:user] do
  gid logstash[:group]
  system true
  shell '/bin/false'
  supports(manage_home: false)
end

logstash.values_at(:basedir, :logdir).each do |dir|
  directory dir do
    owner logstash[:user]
    group logstash[:group]
    mode '755'
    recursive true
    not_if { ::File.directory?(dir) }
  end
end
