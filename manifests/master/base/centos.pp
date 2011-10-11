# Class: puppet::master::base::centos
#
# This class inherits base functionality of the puppet::master::base class.
# It configures centos depended resources
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet::master::base::centos {
  include puppet::master::base
  if $puppet_enable_dashboard {
    $sysconfig_puppetmaster_extra_opts = "--reports puppet_dashboard"
  }
  file{'/etc/sysconfig/puppetmaster':
    content => template('puppet/sysconfig/puppetmaster.erb'),
    #notify => Service['puppetmaster'],
    owner => root, group => 0, mode => 0644;
  }
}
