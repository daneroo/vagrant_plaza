#node[:apache][:listen_ports] = ["80","81"]

#this runs apt-get update update
require_recipe "apt"
# required otherwise the mysql gem will not install
package 'ruby1.8-dev'

Chef::Log.info("DD:mypswd #{node[:mysql][:server_root_password]}")
Chef::Log.info("DD:gitpswd #{node[:gitorious][:db][:password]}")
#Chef::Log.info("DD-:rvmroot #{node[:rvm][:root_path]}")

require_recipe "vagrant_extras"
require_recipe "mysql::server"
require_recipe "rvm"
require_recipe "rvm_passenger"
require_recipe "gitorious"

# Some nice to haves
%w{ iftop curl unzip }.each do |a_package|
  package a_package
end

