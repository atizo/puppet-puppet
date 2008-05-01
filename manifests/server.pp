class puppet::server inherits puppet {
    package { puppet-server: ensure => present }

    service { puppetmaster: ensure => running, enable => true, require => File["/etc/puppet/puppetd.conf"] }
}
