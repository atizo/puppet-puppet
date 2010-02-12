# Class: puppet::master
#
# Based on the operationsystem - fact , this class includes the appropriate 
# puppetmaster functionality. 
# It configures just the basic settings. Additional functions like database,
# lastruncheck or storeconfig has to be included separately 
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  
class puppet::master {
    case $operatingsystem {
        centos: { include puppet::master::base::centos }
        default: { include puppet::master::base }
    }
    if $use_shorewall {
        include shorewall::rules::puppet::master
    }
}

