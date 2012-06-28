# -*- mode: ruby -*-
# vi: set ft=ruby :
HERE = File.dirname(__FILE__)

Vagrant::Config.run do |config|
  config.vm.box     = 'precise64'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'

  config.vm.forward_port 80, 8080

  config.vm.provision :shell, :path => 'kitchen_renovator.sh'
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["#{HERE}/cookbooks", "#{HERE}/site-cookbooks"]
    chef.add_recipe 'passenger_nginx'
    chef.add_recipe 'my-app::deploy'
    chef.json = { :passenger => { :nginx_prefix => '/opt/nginx' } }
  end

end
