class puppet::master::client::ree inherits puppet::master::client {
  File['puppet_config']{
    notify => Service['apache'],
  }
}
