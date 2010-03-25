#
# puppet-dashboard
#
define puppet::master::dashboard(
    $db_adapter = 'mysql',
    $db_name,
    $db_username,
    $db_password,
    $root = '/opt/puppet-dashboard',
) {
    require git
    require rake
    require rubygems::mysql

    $use_dashboard = true

    git::clone{'puppet-dashboard':
        git_repo => 'git://github.com/reductivelabs/puppet-dashboard.git',
        projectroot => '/opt/puppet-dashboard',
        notify => Exec['rake install'],
    }
    exec{'rake install':
        cwd => $root,
        refreshonly => true,
    }
    file{"$root/config/database.yml":
        content => template('modules/puppet/dashboard/database.yml'),
        require => Git::Clone['puppet-dashboard'],
    }
    file{'/usr/lib/ruby/site_ruby/1.8/puppet/reports/puppet_dashboard.rb':
        source => '/opt/puppet-dashboard/lib/puppet/puppet_dashboard.rb',
        require => Git::Clone['puppet-dashboard'],
    }
    service{'dashboard-webrick':
        provider => base,
        ensure => running,
        pattern => "ruby $root/script/server -d",
        start => "$root/script/server -d",
        stop => "kill -9 `ps x | grep 'ruby $root/script/server -d' | grep -v grep | awk '{print $1}'`",
        require => [
            File["$root/config/database.yml"],
            File['/usr/lib/ruby/site_ruby/1.8/puppet/reports/puppet_dashboard.rb'],
        ]
    }
}
