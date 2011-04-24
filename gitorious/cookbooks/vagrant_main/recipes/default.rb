#node[:apache][:listen_ports] = ["80","81"]

#this runs apt-get update update
require_recipe "apt"

Chef::Log.info("DD about to require rubydev")

# required otherwise the mysql gem will not install
#  --need to explain why
#   package 'ruby1.8-dev'
# delays it's installation...

#package 'ruby1.8-dev'
#p = package 'ruby1.8-dev'
#p.run_action(:install)
package('ruby1.8-dev').run_action(:install)
Chef::Log.info("DD done requiring rubydev")

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

