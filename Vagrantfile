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
    centos.vm.network "forwarded_port", guest: 8080, host:8081, auto_correct: true
#    centos.vm.synced_folder ".", "/vagrant", type: "nfs"
    centos.hostmanager.aliases = %w("centos#{c}.localdomain" centos#{c})
    centos.vm.provider "virtualbox" do |v|
      v.memory = 1024
 #     v.gui = true
    end
   end 
  end  
  
  (1..3).each do |u|
   config.vm.define "trusty#{u}" do |ubuntu|
    ubuntu.vm.box = "ubuntu/trusty64"
    ubuntu.vm.hostname = "trusty#{u}.example.com"
    ubuntu.vm.network "private_network", ip: "172.28.128.2#{u}"
#    ubuntu.vm.network "forwarded_port", guest: 8080, host: 8080
    ubuntu.vm.synced_folder ".", "/vagrant", type: "nfs"
    ubuntu.hostmanager.aliases = %w(trusty#{u}.localdomain trusty#{u})
    ubuntu.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
   end
  end

  config.vm.define "xenial1" do |ubuntu|
    ubuntu.vm.box = "ubuntu/xenial64"
    ubuntu.vm.hostname = "xenial1.example.com"
    ubuntu.vm.network "private_network", type: "dhcp"
    ubuntu.vm.network "forwarded_port", guest: 8080, host: 8080
    ubuntu.vm.synced_folder ".", "/vagrant", type: "nfs"
    ubuntu.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end

  end 


end
