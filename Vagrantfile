# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "kasperwps/centos8-kernel6"
  config.vm.synced_folder ".", "/vagrant_data"
  config.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
     vb.cpus = "2"
     vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
   end
   # bug in centos with plugin vagrant-vbguest
   config.vbguest.installer_options = { allow_kernel_upgrade: true }
end
