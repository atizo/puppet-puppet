# Class: puppet::client::base::linux
#
# Inherits basic puppetclient configuration and overrides linux spcific settings.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet::client::base::linux inherits puppet::client::base {
    package{ [ 'puppet', 'facter' ]:
        ensure => present,
    }
    Service['puppet']{
        require => Package['puppet'],
    }
}

