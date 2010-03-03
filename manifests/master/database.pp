# Define: database
#
# This define is used for creating a mysql database
#
# Parameters:
#   $dbname: name of database
#   $host: host on which the db should run
#   $user: database user
#   $password: users password
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
define puppet::master::database(
    $dbname = 'puppet',
    $host = 'localhost',
    $user = 'puppet',
    $password
){
    include puppet::master
    mysql_database{$dbname: }
    mysql_user{"$user@$host":
        password_hash => mysql_password($password),
        require => Mysql_database[$dbname],
    }
    mysql_grant{"$user}@$host/$dbname":
        privileges => all,
        require => Mysql_user["$user@$host"],
    }
    munin::plugin::deploy{'puppetresources':
        source => "puppet/munin/puppetresources.mysql",
        config => "env.mysqlopts --user=$user --password=$password -h $host\nenv.puppetdb $dbname",
    }
}
