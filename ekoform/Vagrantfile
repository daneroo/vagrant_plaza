Vagrant::Config.run do |config|
  config.vm.box = "lucid32"

  # The url from where the 'config.vm.box' box will be fetched if ...
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"

  # config.vm.boot_mode = :gui
  # config.vm.network "33.33.33.10"
  config.vm.forward_port "http", 80, 8080
  config.vm.forward_port "httpdoc", 81, 8081
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"
  config.vm.share_folder("ekoform-dev", "/ekoform-dev", "/Users/daniel/Documents/NetBeansProjects/Ekoform")

  # Enable and configure the chef solo provisioner
  config.vm.provision :chef_solo do |chef|
      # We're going to download our cookbooks from the web
      #chef.recipe_url = "http://files.vagrantup.com/getting_started/cookbooks.tar.gz"
      chef.cookbooks_path =  ["cookbooks", "opscodecookbooks"]

      # Tell chef what recipe to run. In this case, the `vagrant_main` recipe
      # does all the magic.
      chef.add_recipe("vagrant_main")
      #   chef.add_recipe "mysql"
      #   chef.add_role "web"
      #   # You may also specify custom JSON attributes:
      #   chef.json = { :mysql_password => "foo" }
    end

end
