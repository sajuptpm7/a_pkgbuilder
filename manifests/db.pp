class pkbuilder::db {
    service { "mysql":
    enable => true,
    ensure => running,
#    require => Package["mysql-server"],
  }

    mysqldb { "pkbuilder":
        user => "packager",
        password => "packit",
    }
}


define mysqldb( $user, $password ) {
    exec { "create-${name}-db":
      unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
      command => "/usr/bin/mysql -uroot -p$mysql_password -e \"create database ${name}; grant all on ${name}.* to ${user}@localhost identified by '$password';\"",
      require => Service["mysql"],
    }
  }