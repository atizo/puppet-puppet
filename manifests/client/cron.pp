#
# This class inherits from the puppet client's base
# for controlling puppet-Service operations (=> disable service)
# Based on some facts this class includes the appropriate 
# os specific implementation of puppets cron.
# This is an optional featurs for a puppet client.
#
class puppet::client::cron inherits puppet::client {
  require ::cron
  case $kernel {
    linux: { include puppet::client::cron::base::linux }
    openbsd: { include puppet::cron::base::openbsd }
  }
}

