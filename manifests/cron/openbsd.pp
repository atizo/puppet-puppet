class puppet::cron::openbsd inherits puppet::openbsd {
    include puppet::cron::base 
    case $puppet_config {
        '': { $puppet_config = '/etc/puppet/puppet.conf' }
    }
    Openbsd::Add_to_rc_local['puppetd']{
        ensure => 'absent',
    }
    Cron['puppetd_check']{
        ensure => absent,    
    }
    Cron['puppetd_restart']{
        ensure => absent,    
    }

    cron { 'puppetd_run':
        command => "/usr/local/bin/puppetd --onetime --no-daemonize --splay --config=$puppet_config --color false > /dev/null",
        user => 'root',
        minute => [0,30],
    }

}
