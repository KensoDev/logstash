# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "logstash"

  config.vm.box = "debian-7.2.0-amd64-chef"
  config.vm.box_url = "https://s3.amazonaws.com/linux-vbox/debian-7.2.0-amd64-chef.box"

  config.vm.network :private_network, ip: "33.33.33.10"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--cpus", "4"]
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
  end

  config.berkshelf.enabled = true

  config.vm.provision :shell, :inline => "sudo echo \"alias ll='ls -al'\" > /etc/profile.d/ll.sh"

  config.vm.provision :chef_solo do |chef|
    chef.data_bags_path = ENV['CHEF_DATA_BAGS']
    chef.encrypted_data_bag_secret_key_path = ENV['CHEF_SECRET_FILE']
    chef.json = {
    }
    chef.run_list = [
      'recipe[chef-solo-search]',
      'recipe[logstash::default]'
    ]
  end
end
