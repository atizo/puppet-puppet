#
# This class includes plattform independend configuration and
# adds linux specific stuff
#
class puppet::client::cron::base::linux {
  include puppet::client::cron::base
  File{'/etc/cron.d/puppetd':
    content => "0,30 * * * * root /usr/sbin/puppetd --onetime --no-daemonize --splay --config=$puppet_config --color false | grep -E '(^err:|^alert:|^emerg:|^crit:)'\n",
  }
}
