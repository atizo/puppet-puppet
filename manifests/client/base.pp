#
# This is an abstract class which holds basic resources for the puppetclient.
# Do not include this class directly.
#
class puppet::client::base {
  service{'puppet':
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
  }

  if ! $puppet_config {
    $puppet_config = '/etc/puppet/puppet.conf'
  }
  file{'puppet_config':
    path => "$puppet_config",
    source => [
      "puppet:///modules/site-puppet/client/${fqdn}/puppet.conf",
      "puppet:///modules/site-puppet/client/puppet.conf.$operatingsystem",
      "puppet:///modules/site-puppet/client/puppet.conf",
      "puppet:///modules/puppet/client/puppet.conf.$operatingsystem",
      "puppet:///modules/puppet/client/puppet.conf"
    ],
    owner => root, group => 0, mode => 644;
  }

  # restart the client from time to time to avoid memory problems
  file{'/etc/cron.d/puppetd':
    source => [
      "puppet:///modules/puppet/cron.d/puppetd.${operatingsystem}",
      "puppet:///modules/puppet/cron.d/puppetd",
    ],
    owner => root, group => 0, mode => 0644;
  }

  file{'/usr/local/sbin/puppet-stopper':
    source => "puppet:///modules/puppet/client/puppet-stopper",
    owner => root, group => 0, mode => 0500;
  }
}
