# configure puppetmaster to use storedconfigs
class puppet::puppetmaster::storeconfigs inherits puppet::puppetmaster {
    include rails
}
