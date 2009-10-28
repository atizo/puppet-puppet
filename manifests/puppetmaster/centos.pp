# manifests/puppetmaster/centos.pp

class puppet::puppetmaster::centos inherits puppet::puppetmaster::package {
    file{'/etc/sysconfig/puppetmaster':
        source => [ "puppet://$server/site-puppet/sysconfig/${fqdn}/puppetmaster",
                    "puppet://$server/site-puppet/sysconfig/${domain}/puppetmaster",
                    "puppet://$server/site-puppet/sysconfig/puppetmaster",
                    "puppet://$server/puppet/sysconfig/puppetmaster" ],
        notify => Service[puppetmaster],
        owner => root, group => 0, mode => 0644;
    }
}
