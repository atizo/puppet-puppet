class puppet::master::base::centos::ree inherits puppet::master::base::centos {
    File['/etc/sysconfig/puppetmaster']{
        ensure => absent,
    }
}
