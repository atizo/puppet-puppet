#
# This class inherits basic puppet settings 
#
class puppet::base::linux inherits puppet::base {
    package{ [ 'puppet', 'facter' ]:
        ensure => present,
    }
    Service['puppet']{
        require => Package['puppet'],
    }
}

