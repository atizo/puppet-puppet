#
# This class includes plattform independend configuration and
# adds linux specific stuff
#
class puppet::client::cron::base::linux inherits puppet::client::base::linux {
  include puppet::client::cron::base

  if !$puppet_crontime {
    $puppet_crontime_interval_minute = fqdn_rand(29)
    $puppet_crontime_interval_minute2 = inline_template('<%= 30+puppet_crontime_interval_minute.to_i %>')
    $puppet_crontime = "${puppet_crontime_interval_minute},${puppet_crontime_interval_minute2} * * * *"
  }

  File['/etc/cron.d/puppetd']{
    source => undef,
    before => Service['puppet'],
    content => "$puppet_crontime root /usr/sbin/puppetd --onetime --no-daemonize --config=$puppet_config --color false | grep -E '(^err:|^alert:|^emerg:|^crit:)'\n",
  }
}
