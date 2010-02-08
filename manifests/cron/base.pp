class puppet::cron::base inherits puppet::cron {
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
