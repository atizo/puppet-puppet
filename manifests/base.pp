class puppet::base {
    if ! $puppet_config {
        $puppet_config = '/etc/puppet/puppet.conf'
    }
    file{'puppet_config':
        path => "$puppet_config",
        source => [
            "puppet://$server/site-puppet/client/${fqdn}/puppet.conf",
            "puppet://$server/site-puppet/client/puppet.conf.$operatingsystem",
            "puppet://$server/site-puppet/client/puppet.conf",
            "puppet://$server/puppet/client/puppet.conf.$operatingsystem",
            "puppet://$server/puppet/client/puppet.conf"
        ],
        notify => Service['puppet'],
        owner => root, group => 0, mode => 600;
    }
    service{'puppet':
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
        pattern => puppetd,
    }
}
