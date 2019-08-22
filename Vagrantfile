# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "postgres" do |postgres|
    postgres.vm.box = "centos/7"
    postgres.vm.hostname = "postgres"
    postgres.vm.network :forwarded_port, guest: 5432, host: 5432
    postgres.vm.network "private_network", ip: "10.1.1.10"
    postgres.vm.synced_folder ".", "/vagrant", disabled: true
    postgres.vm.provision "shell", path: "vagrant/provisioners/install_postgres.sh"
  end
end
