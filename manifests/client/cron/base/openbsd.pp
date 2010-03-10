#
# This class includes plattform independend configuration and
# adds / overrides openbsd specific stuff
# For doing these overrides it has to inherit from client::base::openbsd
#
class puppet::client::cron::base::openbsd inherits puppet::client::base::openbsd {
    include puppet::client::cron::base
    Openbsd::Rc_local['puppetd']{
        ensure => 'absent',
    }
    Cron['puppetd_check']{
        ensure => absent,    
    }
    Cron['puppetd_restart']{
        ensure => absent,    
    }
    cron{'puppetd_run':
        command => "/usr/local/bin/puppetd --onetime --no-daemonize --splay --config=$puppet_config --color false | grep -E '(^err:|^alert:|^emerg:|^crit:)'",
        user => 'root',
        minute => [0,30],
    }
    File{'/etc/cron.d/puppetd':
        ensure => absent,
    }
}
