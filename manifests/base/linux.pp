# Class: puppet::base::linux
#
# This class inherits basic puppet settings 
#
# Parameters:
#
# Actions:
#   Install the default set of users: [dana,fox]
#
# Requires:
#   - Package["zsh"]
#
# Sample Usage:
#

class puppet::base::linux inherits puppet::base {
    package{ [ 'puppet', 'facter' ]:
        ensure => present,
    }
    Service['puppet']{
        require => Package['puppet'],
    }
}
