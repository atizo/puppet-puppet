#
# This class inherits linux specific puppetclient configuration
# and adds centos specific stuff
#
class puppet::client::base::linux::centos inherits puppet::client::base::linux {
    file{'/etc/sysconfig/puppet':
        source => [
            "puppet://$server/site-puppet/sysconfig/${fqdn}/puppet",
            "puppet://$server/site-puppet/sysconfig/${domain}/puppet",
            "puppet://$server/site-puppet/sysconfig/puppet",
            "puppet://$server/puppet/sysconfig/puppet"
        ],
        notify => Service['puppet'],
        owner => root, group => 0, mode => 0644;
    }
}

