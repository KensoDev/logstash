# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian-7.2.0-amd64-chef"
  config.vm.box_url = "https://s3.amazonaws.com/linux-vbox/debian-7.2.0-amd64-chef.box"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--cpus", "4"]
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
  end

  config.berkshelf.enabled = true

  config.vm.provision :shell, :inline => "sudo echo \"alias ll='ls -al'\" > /etc/profile.d/ll.sh"

  config.vm.define 'redis' do |redis|
    redis.vm.network :private_network, ip: '192.168.10.9'

    redis.vm.provision :chef_solo do |chef|
      chef.run_list = [
        'recipe[redisio::install]',
        'recipe[redisio::enable]'
      ]
    end
  end

  config.vm.define 'indexer' do |indexer|
    indexer.vm.network :private_network, ip: '192.168.10.10'

    indexer.vm.provision :chef_solo do |chef|
      chef.json = {
        'logstash' => {
          'indexer' => {
            'logstash_args' => '-- web',
            'config_input' => [{
              redis: {
                host: '192.168.10.9',
                data_type: :list,
                key: :logstash,
                codec: :json
              }
            }],
            'config_output' => [{
              elasticsearch: {
                embedded: true
              }
            }]
          }
        }
      }
      chef.run_list = [
        'recipe[apt]',
        'recipe[java]',
        'recipe[logstash::indexer]'
      ]
    end
  end

  config.vm.define 'agent' do |agent|
    agent.vm.network :private_network, ip: '192.168.10.11'

    agent.vm.provision :chef_solo do |chef|
      chef.json = {
        'logstash' => {
          'agent' => {
            'config_input' => [{
              file: {
                path: '/tmp/test.log'
              }
            }],
            'config_output' => [{
              redis: {
                host: '192.168.10.9',
                data_type: :list,
                key: :logstash
              }
            }]
          }
        }
      }
      chef.run_list = [
        'recipe[apt]',
        'recipe[java]',
        'recipe[logstash::agent]'
      ]
    end
  end
end
