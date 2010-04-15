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
class puppet::master::base::centos inherits puppet::master::base {
    if $puppet::master::dashboard {
      $sysconfig_puppetmaster_extra_opts = "––reports puppet_dashboard"
    }
    file{'/etc/sysconfig/puppetmaster':
        content => template('sysconfig/puppetmaster.erb'),
        notify => Service['puppetmaster'],
        owner => root, group => 0, mode => 0644;
    }
}
