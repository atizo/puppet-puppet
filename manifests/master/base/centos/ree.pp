class puppet::master::base::centos::ree inherits puppet::master::base::centos {
  include puppet::master::base::ree
  File['/etc/sysconfig/puppetmaster']{
    ensure => absent,
  }
}
