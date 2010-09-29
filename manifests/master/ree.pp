class puppet::master::ree {
  include puppet::master
  include puppet::master::client::ree
  case $operatingsystem {
    centos: { include puppet::master::base::centos::ree }
    default: { include puppet::master::base::ree }
  }
}
