class puppet::base::linux::gentoo inherits puppet::base::linux {
    Package['puppet']{
        category => 'app-admin',
    }
    Package['facter']{
        category => 'dev-ruby',
    }
    # as we use sometimes the init script to test
    Service['puppet']{
        hasstatus => false,
    }
}
