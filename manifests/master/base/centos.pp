# Class: puppet::master::base::centos
#
# This class inherits base functionality of the puppet::master::base class.
# It configures centos depended resources
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet::master::base::centos inherits puppet::master::base {
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

