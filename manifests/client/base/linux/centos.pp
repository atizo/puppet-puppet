#
# This class inherits linux specific puppetclient configuration
# and adds centos specific stuff
#
class puppet::client::base::linux::centos inherits puppet::client::base::linux {
  file{'/etc/sysconfig/puppet':
    source => [
      "puppet:///modules/site-puppet/sysconfig/${fqdn}/puppet",
      "puppet:///modules/site-puppet/sysconfig/${domain}/puppet",
      "puppet:///modules/site-puppet/sysconfig/puppet",
      "puppet:///modules/puppet/sysconfig/puppet"
    ],
    notify => Service['puppet'],
    owner => root, group => 0, mode => 0644;
  }
}

