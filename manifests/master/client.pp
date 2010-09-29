class puppet::master::client inherits puppet::client::base {
  File['puppet_config']{
    source => [
      "puppet:///modules/site-puppet/master/puppet.conf",
      "puppet:///modules/puppet/master/puppet.conf",
    ],
    notify => Service['puppetmaster'],
  }
}
