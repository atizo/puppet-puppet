# Class: puppet::client::base::linux::gentoo
#
# This class inherits linux specific puppetclient configuration
# and adds gentoo specific stuff
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet::client::base::linux::gentoo inherits puppet::client::base::linux {
    Package['puppet']{
        category => 'app-admin',
    }
    Package['facter']{
        category => 'dev-ruby',
    }
    # as we use sometimes the init script to test
    Service['puppet']{
        hasstatus => false,
    }
}
