class puppet::master::lastruncheck::disable inherits puppet::master::lastruncheck {
  File['/etc/cron.d/puppetlast.cron']{
    ensure => absent,  
  }
}
