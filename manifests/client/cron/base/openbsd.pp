#
# This class includes plattform independend configuration and
# adds / overrides openbsd specific stuff
# For doing these overrides it has to inherit from client::base::openbsd
#
class puppet::client::cron::base::openbsd inherits puppet::client::base::openbsd {
  include puppet::client::cron::base

  if !$puppet_crontime {
    $puppet_crontime_interval_minute = fqdn_rand(29)
    $puppet_crontime_interval_minute2 = inline_template('<%= 30+puppet_crontime_interval_minute.to_i %>')
    $puppet_crontime = "${puppet_crontime_interval_minute},${puppet_crontime_interval_minute2} * * * *"
  }

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
    minute => split(regsubst($puppet_crontime,'^([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+)$','\1'),','),
    hour => split(regsubst($puppet_crontime,'^([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+)$','\2'),','),
    weekday => split(regsubst($puppet_crontime,'^([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+)$','\3'),','),
    month => split(regsubst($puppet_crontime,'^([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+)$','\4'),','),
    monthday => split(regsubst($puppet_crontime,'^([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+)$','\5'),',')
  }
  File{'/etc/cron.d/puppetd':
    ensure => absent,
  }
}
