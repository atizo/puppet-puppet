# Class: puppet::client::base::linux::debian
#
# This class inherits linux specific puppetclient configuration
# and adds debian specific stuff
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet::client::base::linux::debian inherits puppet::client::base::linux {
    file{'/etc/default/puppet':
        source => [
            "puppet://$server/site-puppet/client/debian/${fqdn}/puppet",
            "puppet://$server/site-puppet/client/debian/${domain}/puppet",
            "puppet://$server/site-puppet/client/debian/puppet",
            "puppet://$server/puppet/client/debian/puppet",
        ],
        notify => Service['puppet'],
        owner => root, group => 0, mode => 0644;
    }
    # there is really no status cmd for it
    Service['puppet']{
        hasstatus => false,
    }
}

