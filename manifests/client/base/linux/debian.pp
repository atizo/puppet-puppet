#
# This class inherits linux specific puppetclient configuration
# and adds debian specific stuff
#
class puppet::client::base::linux::debian inherits puppet::client::base::linux {
  file{'/etc/default/puppet':
    source => [
      "puppet:///modules/site-puppet/client/debian/${fqdn}/puppet",
      "puppet:///modules/site-puppet/client/debian/${domain}/puppet",
      "puppet:///modules/site-puppet/client/debian/puppet",
      "puppet:///modules/puppet/client/debian/puppet",
    ],
    notify => Service['puppet'],
    owner => root, group => 0, mode => 0644;
  }
  # there is really no status cmd for it
  Service['puppet']{
    hasstatus => false,
  }
}

