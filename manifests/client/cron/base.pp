#
# This class configures plattform independed cron configuration
#
class puppet::client::cron::base inherits puppet::client::base {
  Service['puppet']{
    ensure => stopped,
    enable => false,
    hasstatus => true,
  }
  exec{'stop_puppet':
    command => 'kill `cat /var/run/puppet/puppetd.pid`',
    onlyif => 'test -f /var/run/puppet/puppetd.pid',
    require => Service['puppet'],
  }
}
