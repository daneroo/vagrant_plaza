# Vagrant box as base for gitorious

_NOTE_ How did `/etc/apt/sources.list.d/opscode.list` get there
(`deb http://apt.opscode.com/ maverick main`)

_NOTE_ currently needs a fix to work

    $ git diff gem.rb 
    diff --git a/providers/gem.rb b/providers/gem.rb
    index 0274da0..9b3ffd0 100644
    --- a/providers/gem.rb
    +++ b/providers/gem.rb
    @@ -100,7 +100,7 @@ def gem_package_wrapper(exec_action, ruby_string=new_resource.ruby_string)
       profile = find_profile_to_source
 
       g = gem_package new_resource.gem do
    -    gem_binary  %{bash -c "source #{profile}" && rvm #{ruby_string} gem}
    +    gem_binary  %{bash -c "source #{profile} && rvm #{ruby_string} gem"}
         source      new_resource.source if new_resource.source
         options     new_resource.options if new_resource.options
         version     new_resource.version if new_resource.version

This box was made for two reasons:

*   Installing rvm environments is very slow
*   To eliminate some of the issues around chef being run in two separate passes, 
or having some actions being delayed (such as installing rub1.8-dev), or having the chef run itself use an rvm ruby

The build takes about 20 minutes for me, and saves that time on the gitorious build
for which it was extracted

## Dependencies

* fnichols recipes: `vagrant_extras`,rvm``

Steps, build, package (makes `package.box`), install, cleanup

    vagrant up      # build the vbox image
    vagrant package # make the `package.box`
    vagrant destroy # removes the virtualbox instance
    vagrant box add rvm-ubu1010 package.box  # add the box for other vagrant to use
    rm package.box  # clean up

Optionally, you can include the Vagrantfile, and anything else you need to ship with the box
like this:

    vagrant package --include README.md
    
See the docs at [vagrantup.com](http://vagrantup.com/docs/boxes.html).