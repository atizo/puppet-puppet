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

    yum::managed_yumrepo{'puppetlabs':
        descr => 'Puppet Labs Packages',
        baseurl => "http://yum.puppetlabs.com/base/",
        enabled => 1,
        gpgcheck => 1,
        gpgkey => "http://yum.puppetlabs.com/RPM-GPG-KEY-reductive"
        priority => 1,
    }
    package{'puppet-dashboard'
        ensure => installed,
    }
#    exec{'rake install':
#        cwd => $root,
#        refreshonly => true,
#    }
#    file{"$root/config/database.yml":
#        content => template('modules/puppet/dashboard/database.yml'),
#        require => Package['puppet-dashboard'],
#    }
#    file{'/usr/lib/ruby/site_ruby/1.8/puppet/reports/puppet_dashboard.rb':
#        source => '/opt/puppet-dashboard/lib/puppet/puppet_dashboard.rb',
#        require => Package['puppet-dashboard'],
#    }
#    service{'dashboard-webrick':
#        provider => base,
#        ensure => running,
#        pattern => "ruby $root/script/server -d",
#        start => "$root/script/server -d",
#        stop => "kill -9 `ps x | grep 'ruby $root/script/server -d' | grep -v grep | awk '{print $1}'`",
#        require => [
#            File["$root/config/database.yml"],
#            File['/usr/lib/ruby/site_ruby/1.8/puppet/reports/puppet_dashboard.rb'],
#        ]
#    }
}
