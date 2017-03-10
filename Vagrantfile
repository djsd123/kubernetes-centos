# -*- mode: ruby -*-
# vi: set ft=ruby :
ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.configure(2) do |config|
  

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true
  
  (1..3).each do |c|
   config.vm.define "centos#{c}" do |centos|
    centos.vm.box = "puppetlabs/centos-7.0-64-puppet"
    centos.vm.box_version = "1.0.1"
    centos.vm.provision "puppet"
    centos.vm.hostname = "centos#{c}.example.com"
    centos.vm.network "private_network", ip: "172.28.128.1#{c}"
    centos.vm.network "forwarded_port", guest: 80, host:8081, auto_correct: true
    centos.hostmanager.aliases = %w("centos#{c}.localdomain" centos#{c})
    centos.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
   end 
  end

end
