# Class: base
#
# This is an abstract class which holds basic resources that are in common
# with puppetmaster and puppetclient. do not include this class directly. 
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  
class puppet::base {
    if ! $puppet_config {
        $puppet_config = '/etc/puppet/puppet.conf'
    }
    file{'puppet_config':
        path => "$puppet_config",
        source => [
            "puppet://$server/modules/site-puppet/client/${fqdn}/puppet.conf",
            "puppet://$server/modules/site-puppet/client/puppet.conf.$operatingsystem",
            "puppet://$server/modules/site-puppet/client/puppet.conf",
            "puppet://$server/modules/puppet/client/puppet.conf.$operatingsystem",
            "puppet://$server/modules/puppet/client/puppet.conf"
        ],
        owner => root, group => 0, mode => 644;
    }
}

