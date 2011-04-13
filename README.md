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


Experiments
----------

* ekoform php application
* basebox : 
    [fnichol](https://github.com/fnichol) also has some nice [definitions](https://github.com/fnichol/veewee-definitions)


		sudo gem install [veewee](https://github.com/jedi4ever/veewee)
		vagrant basebox define 'axbase' 'ubuntu-10.10-server-i386'
		vagrant basebox build 'axbase'
		vagrant basebox validate axbase
		vagrant basebox export   axbase

* gitorious : gitorious server - based on fnichol chef cookbooks
* gitorious-pp: sugarlabs based [puppet install](http://git.sugarlabs.org/puppets)
    
* openvpn pair
* couchdb demo app


