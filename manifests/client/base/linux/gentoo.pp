#
# This class inherits linux specific puppetclient configuration
# and adds gentoo specific stuff
#
class puppet::client::base::linux::gentoo inherits puppet::client::base::linux {
  Package['puppet']{
    category => 'app-admin',
  }
  Package['facter']{
    category => 'dev-ruby',
  }
}

