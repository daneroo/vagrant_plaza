# Basic Puppet manifests

$my_root = {
    user     => "root",
    password => "pass",
    host     => "localhost",
}

class { "mysql::server":
    my_root      => $my_root,
    bind_address => "localhost",
}

class lucid32 {

  package { "apache2":
    ensure => present,
  }

  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }
}

include lucid32

