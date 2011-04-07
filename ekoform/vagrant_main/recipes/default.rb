#set:apache[:listen_ports] = ["80","81"]
node[:apache][:listen_ports] = ["80","81"]

require_recipe "apt"
require_recipe "apache2"
require_recipe "php"


# Some nice to haves
%w{ iftop curl unzip }.each do |a_package|
  package a_package
end

# mongo repo key
execute "mongo-10gen-key" do
  command "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
  action :run                                                                                                                                                
end

# mongo repo
# deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen
apt_repository "mongo10gen" do
  uri "http://downloads-distro.mongodb.org/repo/ubuntu-upstart"
  distribution "dist"
  components ["10gen"]
  action :add
end

# install mongo pkg
%w{ mongodb-10gen }.each do |a_package|
  package a_package
end

execute "mongo-copy-forms-ci-to-dev" do
  command %q(mongo --eval 'db.copyDatabase("forms_ci", "forms_dev", "ci.axialdev.net");')
  action :run                                                                                                                                                
  #action :nothing
end

execute "mongo-count-quests" do
  command %q(mongo --eval 'db.quests.count()' forms_dev)
  #  action :run                                                                                                                                                
  action :nothing
end

# PHP extras
php_pear "mongo" do
  action :install
end

# required by apc
%w{ libpcre3-dev }.each do |a_package|
  package a_package
end

# use 3.1.6, cause 3.1.7 is beta and dumps a bunch of crap in the logs.
php_pear "apc" do
  action :install
  version "3.1.6"
  directives(:shm_size => '64M', :enable_cli => 1)
end
=begin
Example with pear channel
sc = php_pear_channel "pear.symfony-project.com" do
  action :discover
end
php_pear "YAML" do
  channel sc.channel_name
  action :install
end

From jenkins install
sudo pear channel-discover pear.pdepend.org
sudo pear channel-discover pear.phpmd.org
sudo pear channel-discover pear.phpunit.de
sudo pear channel-discover components.ez.no
sudo pear channel-discover pear.symfony-project.com

sudo pear upgrade

sudo pear install pdepend/PHP_Depend-beta
sudo pear install phpmd/PHP_PMD-alpha
sudo pear install phpunit/phpcpd
sudo pear install phpunit/phploc
sudo pear install PHPDocumentor
sudo pear install PHP_CodeSniffer
sudo pear install --alldeps phpunit/PHP_CodeBrowser
sudo pear install --alldeps phpunit/PHPUnit
=end

execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end
execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end

web_app "ekoform-dev" do
  template "ekoform-dev.conf.erb"
  notifies :reload, resources(:service => "apache2"), :delayed
end
web_app "docserver-dev" do
  template "docserver-dev.conf.erb"
  notifies :reload, resources(:service => "apache2"), :delayed
end

# now docserver
user 'docserver' do
  comment "Document Server"
  home "/home/docserver"
  supports  :manage_home => true
end
# and its content
execute "docserver-deploy" do
  user 'docserver'
  group 'docserver'
  cwd '/home/docserver'
  command "tar xzvf /vagrant/docserver-dev.tgz"
  action :run                                                                                                                                                  
end
