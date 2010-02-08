define puppet::puppetmaster::database(
    $dbname = 'puppet',
    $host = 'localhost',
    $user = 'puppet',
    $password,
){
    mysql_database{$dbname: }
    mysql_user{"$user@$host":
        password_hash => mysql_password($password),
        require => Mysql_database[$dbname],
    }
    mysql_grant{"$user}@$host/$dbname":
        privileges => all,
        require => Mysql_user["$dbuser@$host"],
    }
    munin::plugin::deploy{'puppetresources':
        source => "puppet/munin/puppetresources.mysql",
        config => "env.mysqlopts --user=$user --password=$password -h $host\nenv.puppetdb $dbname",
    }
}
