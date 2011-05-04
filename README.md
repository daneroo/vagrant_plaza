Vagrant Playground
==================

This will hold [vagrant](http://vagrantup.com/) experiments

Get a new machine up:

		# first time only
		$ gem install vagrant
		$ vagrant box add lucid32 http://files.vagrantup.com/lucid32.box
		# to make a new box
		$ vagrant init lucid32
		$ vagrant up

Git:
when checking out nested submodules use:

    git submodule update --init --recursive

recursive submodule update:

    git submodule update
    git submodule foreach --recursive git pull origin master

Experiments
----------

* ekoform php application
* basebox : 
    [fnichol](https://github.com/fnichol) also has some nice [definitions](https://github.com/fnichol/veewee-definitions)


    Might want to remove the `deb http://apt.opscode.com..` from `/etc/apt/sources.list.d/opscode.list`
    which is installed by the veewee definitions.

		sudo gem install [veewee](https://github.com/jedi4ever/veewee)
		vagrant basebox define 'axbase' 'ubuntu-10.10-server-i386'
		vagrant basebox build 'axbase'
		vagrant basebox validate axbase
		vagrant basebox export   axbase

* gitorious : gitorious server - based on fnichol chef cookbooks
* gitorious-pp: sugarlabs based [puppet install](http://git.sugarlabs.org/puppets)
    *these are submodules on git.sugarlabs.org gitorious
    
    
* openvpn pair
* couchdb demo app

## Gitoruous Notes
Networking:

Give Vagrant box a known host only ip address

    config.vm.network("192.168.11.11")

define gitorious.local as a host only ip on host: /etc/hosts

    192.168.11.11	www.gitorious.local gitorious.local

Added -l debug to `run_chef_solo()` while debugging gitorious recipe

    # vagrant gem version may change 0.7.2 0.7.3
    sudo emacs /Library/Ruby/Gems/1.8/gems/vagrant-0.7.3/lib/vagrant/provisioners/chef_solo.rb
    def run_chef_solo
      #commands = ["cd #{config.provisioning_path}", "chef-solo -c solo.rb -j dna.json"]
      commands = ["cd #{config.provisioning_path}", "chef-solo -c solo.rb -j dna.json -l debug"]

