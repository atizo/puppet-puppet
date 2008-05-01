class puppet {
    file { "/etc/puppet/puppet.conf":
        # That's a lot of puppets!
        source => "puppet:///puppet/puppet.conf",
        owner => root,
        group => root,
        mode => 644
    }

    service { puppetd: ensure => running }
}
