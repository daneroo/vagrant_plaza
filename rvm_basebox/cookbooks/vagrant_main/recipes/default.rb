#node[:apache][:listen_ports] = ["80","81"]

# setup apt canada
Chef::Log.info("DD:ubuntu #{node[:lsb][:codename]} from #{node['ubuntu']['archive_url']}")
require_recipe "ubuntu"

# should this go after rvm recipe:
# probably cause if it install rvm is not immediately available!
# vagrant extras does the following:
# -make a paswwordles vagrant sudoers (not necessary)
# -make a /usr/local/bin/chef-solo which uses rvm
# -make vagrant part of rvm group (why?)
require_recipe "vagrant_extras"

# install ruby-1.9.2 and ree-1.8.7 as per node[:rvm][:rubies]
require_recipe "rvm"

# Some nice to haves: ruby1.8-dev is for the mysql gem
%w{ iftop curl unzip ruby1.8-dev }.each do |a_package|
  package a_package
end

