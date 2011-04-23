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
    *these are submodules on git.sugarlabs.org gitorious
    
    
* openvpn pair
* couchdb demo app

Fixed: in `devops/vagrant_plaza/fnicholcookbooks/rvm`

    dirac:rvm daniel$ git diff
    diff --git a/providers/gem.rb b/providers/gem.rb
    index 1447cb2..9b3ffd0 100644
    --- a/providers/gem.rb
    +++ b/providers/gem.rb
    @@ -100,7 +100,7 @@ def gem_package_wrapper(exec_action, ruby_string=new_resource.ruby_string)
       profile = find_profile_to_source
 
       g = gem_package new_resource.gem do
    -    gem_binary  "source #{profile} && rvm #{ruby_string} gem"
    +    gem_binary  %{bash -c "source #{profile} && rvm #{ruby_string} gem"}
         source      new_resource.source if new_resource.source
         options     new_resource.options if new_resource.options
         version     new_resource.version if new_resource.version
