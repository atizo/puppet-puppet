class puppet::puppetmaster inherits puppet {
    case $operatingsystem {
        centos: { include puppet::puppetmaster::base::centos }
        default: { include puppet::puppetmaster::base }
    }
    include puppet::puppetmaster::checklastrun
    if $use_shorewall {
        include shorewall::rules::puppet::master
    }
}
