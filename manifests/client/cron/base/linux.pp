# Class: puppet::client::cron::base::linux
#
# This class includes plattform independend configuration and
# adds linux specific stuff
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet::client::cron::base::linux {
    include puppet::client::cron::base
    file{'/etc/cron.d/puppetd.cron':
        content => "0,30 * * * * root /usr/sbin/puppetd --onetime --no-daemonize --splay --config=$puppet_config --color false | grep -E '(^err:|^alert:|^emerg:|^crit:)'\n",
    }
}

