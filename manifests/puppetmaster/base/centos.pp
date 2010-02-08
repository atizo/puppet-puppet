class puppet::puppetmaster::base::centos inherits puppet::puppetmaster::base {
    file{'/etc/sysconfig/puppetmaster':
        source => [
            "puppet://$server/site-puppet/sysconfig/${fqdn}/puppetmaster",
            "puppet://$server/site-puppet/sysconfig/${domain}/puppetmaster",
            "puppet://$server/site-puppet/sysconfig/puppetmaster",
            "puppet://$server/puppet/sysconfig/puppetmaster",
        ],
        notify => Service['puppetmaster'],
        owner => root, group => 0, mode => 0644;
    }
}
