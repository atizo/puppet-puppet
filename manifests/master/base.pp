# Class: puppet::master::base.pp
#
# This is an abstract class which holds basic puppetmaster resources.
# It is plattform independent.  
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet::master::base {
  if ! $puppet_fileserverconfig {
    $puppet_fileserverconfig = '/etc/puppet/fileserver.conf'
  }
  if $puppet_enable_dashboard {
    if !$puppet_dashboard_db_password {
      fail("You need to set \$puppet_dashboard_db_password if you want to use dashboard on $fqdn")
    }
    puppet::master::dashboard{$hostname:
      db_name => 'dashboard',
      db_username => 'dashboard',
      db_password => $puppet_dashboard_db_password,
      dashboard_vhost => $puppet_dashboard_vhost,
      dashboard_vhost_options => $puppet_dashboard_vhost_options,
    }
  }
  package{'puppet-server':
    ensure => present,
  }
  service{'puppetmaster':
    ensure => running,
    enable => true,
    require => Package['puppet'],
  }
  file{$puppet_fileserverconfig:
    source => [
      "puppet:///modules/site-puppet/master/${fqdn}/fileserver.conf",
      "puppet:///modules/site-puppet/master/fileserver.conf",
      "puppet:///modules/puppet/master/fileserver.conf",
    ],
    notify => Service['puppetmaster'],
    owner => root, group => 0, mode => 644;
  }
  # restart the master from time to time to avoid memory problems
  file{'/etc/cron.d/puppetmaster.cron':
    source => [
      "puppet:///modules/puppet/cron.d/puppetmaster.${operatingsystem}",
      "puppet:///modules/puppet/cron.d/puppetmaster",
    ],
    owner => root, group => 0, mode => 0644;
  }
  file{'/etc/cron.daily/puppet_reports_cleanup.sh':
    content => "#!/bin/bash\nfind /var/log/puppet/reports/ -maxdepth 2 -type f -ctime +30 -exec rm {} \\;\n",
    owner => root, group => 0, mode => 0700;
  }
}
