#######################################
# puppet module
# original by luke kanies
# http://github.com/lak
# adaapted by puzzel itc
#######################################
class puppet {
    file { "/etc/puppet/puppet.conf":
        # That's a lot of puppets!
        source => "puppet:///puppet/puppet.conf",
        owner => root,
        group => root,
        mode => 644
    }

    file { "/etc/puppet/namespaceauth.conf":
        # That's a lot of puppets!
        source => "puppet:///puppet/namespaceauth.conf",
        owner => root,
        group => root,
        mode => 644
    }

    service { puppet:
        ensure => running,
        pattern => puppetd,
        require => [File["/etc/puppet/namespaceauth.conf"], File["/etc/puppet/puppet.conf"]]
    }
}
