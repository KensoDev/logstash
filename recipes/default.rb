group node[:logstash][:group]

user node[:logstash][:user] do
  gid node[:logstash][:group]
  system true
  shell '/bin/false'
  supports(manage_home: false)
end

default[:logstash].values_at(:basedir, :logdir).each do |dir|
  directory dir do
    owner node[:logstash][:user]
    group node[:logstash][:group]
    mode '755'
    recursive true
    not_if { ::File.directory?(dir) }
  end
end
