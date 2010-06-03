# by default we do run puppetmaster on REE only with passenger
# everything else should be tweaked later
class puppet::master::base::ree inherits puppet::master::base {
    require ruby-enterprise
    require passenger::ree::apache

    if $puppet_enable_dashboard {
        Puppet::Master::Dashboard[$hostname]{
            ruby_mode => 'ree',
        }
    }


    Package['puppet-server']{
        ensure => absent,
    }
    Service['puppetmaster']{
        ensure => stopped,
        enable => false,
        before => Package['puppet'],
        require => undef
    }
    File['/etc/cron.d/puppetmaster.cron']{
        ensure => absent,
    }

    ruby-enterprise::gem{'puppet': }
    if $puppet_use_storedconfigs {
        ruby-enterprise::gem{ [ 'rails', 'mysql']: }
    }

    if !$puppet_master_certname {
        fail("you need to set \$puppet_master_certname on $fqdn to be able to configure passenger")
    }

    file{ [ '/usr/share/puppet/rack',
            '/usr/share/puppet/rack/puppetmasterd',
            '/usr/share/puppet/rack/puppetmasterd/public' ]:
        ensure => directory,
    }
    file{'/usr/share/puppet/rack/puppetmasterd/tmp':
        ensure => directory,
        owner => puzzle, group => 0, mode => 0644;
    }

    file{'/usr/share/puppet/rack/puppetmasterd/config.ru':
        content => template('puppet/passenger/config.ru.erb'),
        require => File['/usr/share/puppet/rack/puppetmasterd/tmp', '/usr/share/puppet/rack/puppetmasterd/public'],
        owner => puppet, group => 0, mode => 0644;
    }
    apache::vhost::file{'puppetmaster':
        content => template('puppet/passenger/puppetmaster.erb'),
        require => File['/usr/share/puppet/rack/puppetmasterd/config.ru'],
    }    
}
