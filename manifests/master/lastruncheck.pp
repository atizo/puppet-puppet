# Class: lastruncheck
#
# installs cronjob which reports the last check-in time of nodes.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet::master::lastruncheck {
  include puppet::master
  file{'/usr/local/sbin/lastruncheck':
    source => "puppet:///modules/puppet/master/lastruncheck",
    owner => root, group => 0, mode => 0755;
  }

  $puppet_lastruncheck_ignorehosts_str = $puppet_lastruncheck_ignorehosts ? {
    '' => '',
    undef => '',
    default => "--ignore-hosts ${puppet_lastruncheck_ignorehosts}"
  }

  $puppet_lastruncheck_timeout_str = $puppet_lastruncheck_timeout ? {
    '' => '',
    undef => '',
    default => "--timeout ${puppet_lastruncheck_timeout}"
  }

  file{'/etc/cron.d/puppetlast.cron':
    content => "40 10,22 * * * root /usr/local/sbin/lastruncheck ${puppet_lastruncheck_timeout_str} ${puppet_lastruncheck_ignorehosts_str} ${$puppet_lastruncheck_additionaloptions}\n",
    owner => root, group => 0, mode => 0644;
  }
}
