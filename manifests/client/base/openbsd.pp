#
# Inherits basic puppetclient configuration and overrides openbsd spcific settings.
#
class puppet::client::base::openbsd inherits puppet::client::base {
  Service['puppet']{
    restart => '/bin/kill -HUP `/bin/cat /var/run/puppet/puppetd.pid`',
    stop => '/bin/kill `/bin/cat /var/run/puppet/puppetd.pid`',
    start => '/usr/local/bin/puppetd',
    hasstatus => false,
    hasrestart => false,
    pattern => 'puppet agent',
  }
  openbsd::rc_local{'puppetd':
    binary => '/usr/local/bin/puppetd',
  }
  cron{'puppetd_check':
    command => '/bin/ps ax | /usr/bin/grep -v grep | /usr/bin/grep -q puppetd || (sleep `echo $RANDOM/2000*60 | bc` && /usr/local/bin/puppetd)',
    user => root,
    minute => 0,
  }
  cron{'puppetd_restart':
    command => 'sleep `echo $RANDOM/2000*60 | bc` && /bin/kill `/bin/cat /var/run/puppet/puppetd.pid`; /usr/local/bin/puppetd',
    minute => 0,
    hour => 22,
    monthday => '*/2',
  }
}

