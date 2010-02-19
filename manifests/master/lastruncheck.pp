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
    ifile{'/usr/local/sbin/lastruncheck':
        source => "puppet://$server/modules/puppet/master/lastruncheck"
        owner => root, group => 0, mode => 0644;
    }
    file{'/etc/cron.d/puppetlast.cron':
        content => "40 10,22 * * * root /usr/local/sbin/lastruncheck\n",
        owner => root, group => 0, mode => 0644;
    }
}
