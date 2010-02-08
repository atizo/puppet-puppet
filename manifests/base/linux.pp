class puppet::base::linux inherits puppet::base {
    # package bc needed for cron
    include bc

    package{ [ 'puppet', 'facter' ]:
        ensure => present,
    }
    Service['puppet']{
        require => Package['puppet'],
    }
    file{'/etc/cron.d/puppetd.cron':
        source => [
            "puppet://$server/puppet/cron.d/puppetd.${operatingsystem}",
            "puppet://$server/puppet/cron.d/puppetd",
        ],
        owner => root, group => 0, mode => 0644;
    }
}
