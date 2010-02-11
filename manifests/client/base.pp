# Class: client::base
#
# This is an abstract class which holds basic resources for the puppetclient.
# It also inherits puppet's base functionality (puppet::base)
# Do not include this class directly.
#
# Actions:
#
# Requires:
#
# Sample Usage:
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
        notify +> Service['puppet'],
    }

}
