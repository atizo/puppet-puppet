#
# This is an abstract class which holds basic resources for the puppetclient.
# It also inherits puppet's base functionality (puppet::base)
# Do not include this class directly.
#
class puppet::client::base inherits puppet::base {
    include puppet::base
    service{'puppet':
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
        pattern => puppetd,
    }
    File['puppet_config']{
        notify => Service['puppet'],
    }
    # restart the client from time to time to avoid memory problems
    file{'/etc/cron.d/puppetd':
        source => [
            "puppet://$server/puppet/cron.d/puppetd.${operatingsystem}",
            "puppet://$server/puppet/cron.d/puppetd",
        ],
        owner => root, group => 0, mode => 0644;
    }
}
