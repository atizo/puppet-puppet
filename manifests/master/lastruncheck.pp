# Class: lastruncheck
#
# installs cronjob which reports the last check-in time of nodes.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet::master::lastruncheck {
    include puppet::master
    file{'/etc/cron.d/puppetlast.cron':
        content => "40 10,22 * * * root /usr/share/puppet/ext/puppetlast\n",
        require => File['/opt/bin/puppetlast'],
        owner => root, group => 0, mode => 0644;
    }
}
