#
# Inherits basic puppetclient configuration and overrides linux spcific settings.
#
class puppet::client::base::linux inherits puppet::client::base {
    package{ [ 'puppet', 'facter' ]:
        ensure => present,
    }
    Service['puppet']{
        require => Package['puppet'],
    }
}

