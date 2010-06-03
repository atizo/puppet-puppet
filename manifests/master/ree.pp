class puppet::master::ree inherits puppet::master {
    case $operatingsystem {
        centos: { include puppet::master::base::centos::ree }
        default: { include puppet::master::base::ree }
    }
}
