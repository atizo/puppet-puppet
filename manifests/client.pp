# Class: puppet::client
#
# Based on the operationsystem and kernel - fact , this class includes the appropriate 
# puppetclient functionality. 
# It configures just the basic settings. Additional functions have to be included separately
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#

class puppet::client {
  case $kernel {
    linux: {
      case $operatingsystem {
        gentoo:  { include puppet::client::base::linux::gentoo }
        centos:  { include puppet::client::base::linux::centos }
        debian:  { include puppet::client::base::linux::debian }
        default: { include puppet::client::base::linux }
      }
    }
    openbsd: { include puppet::client::base::openbsd }
    default: { include puppet::client::base }
  }
  if $use_shorewall {
    include shorewall::rules::out::puppet
  }
}

