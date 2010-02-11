# Class: puppet::client::cron::base
#
# This class configures plattform independed cron configuration
#
# Parameters:
#
# Actions:
# Disable puppet service
#
# Requires:
#
# Sample Usage:
#
class puppet::client::cron::base inherits puppet::client::base {
    Service['puppet']{
        enable => false,
        hasstatus => false,
    }
    exec{'stop_puppet':
        command => 'kill `cat /var/run/puppet/puppetd.pid`',
        onlyif => 'test -f /var/run/puppet/puppetd.pid',
        require => Service['puppet'],
    }
}
