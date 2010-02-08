class puppet::cron::base::linux inherits puppet::cron::base {
    file{'/etc/cron.d/puppetd.cron':
        content => "0,30 * * * * root /usr/sbin/puppetd --onetime --no-daemonize --splay --config=$puppet_config --color false | grep -E '(^err:|^alert:|^emerg:|^crit:)'\n",
    }
}
