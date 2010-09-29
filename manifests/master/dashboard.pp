#
# puppet-dashboard
#
define puppet::master::dashboard(
  $db_adapter = 'mysql',
  $db_name,
  $db_username,
  $db_password,
  $dashboard_vhost,
  $dashboard_vhost_options,
  $ruby_mode = 'normal'
) {
  require rake
  require puppet::master

  yum::managed_yumrepo{'puppetlabs':
    descr => 'Puppet Labs Packages',
    baseurl => "http://yum.puppetlabs.com/base/",
    enabled => 1,
    gpgcheck => 1,
    gpgkey => "http://yum.puppetlabs.com/RPM-GPG-KEY-reductive",
    priority => 1,
  }
  package{'puppet-dashboard':
    ensure => installed,
  }

  file{'/usr/share/puppet-dashboard/config/database.yml':
    content => template('puppet/dashboard/database.yml.erb'),
    require => Package['puppet-dashboard'],
    owner => puppet, group => 0, mode => 0400;
  }

  mysql_database{"$db_name":
    ensure => present
  }
  mysql_user{"${db_username}@localhost":
    ensure => present,
    password_hash => mysql_password($db_password),
    require => Mysql_database["$db_name"],
  }
  mysql_grant{"${db_username}@localhost/${db_name}":
    privileges => "all",
    require => [ Mysql_user["${db_username}@localhost"], Mysql_database[$db_name] ],
  }
  exec{'install_dashboard':
    cwd => '/usr/share/puppet-dashboard/',
    unless => "echo 'show tables;' | mysql --user=${db_username} --password=${db_password} ${db_name} > /dev/null",
    require => [ Mysql_grant["${db_username}@localhost/${db_name}"], File['/usr/share/puppet-dashboard/config/database.yml'] ],
  }

  file{'puppet_dashboard.rb':
    content => template('puppet/dashboard/puppet_dashboard.rb.erb'),
  }
  if $ruby_mode == 'ree' {
    require puppet::master::ree

    Exec['install_dashboard']{
      command => 'RAILS_ENV=production /opt/ruby-enterprise/bin/rake install'
    }
    File['puppet_dashboard.rb']{
      path => "/opt/ruby-enterprise/lib/ruby/gems/1.8/gems/puppet-${puppetversion}/lib/puppet/reports/puppet_dashboard.rb"
    }
    require passenger::ree::apache    
  } else {
    Exec['install_dashboard']{
      command => 'RAILS_ENV=production rake install',
    }
    File['puppet_dashboard.rb']{
      path => '/usr/lib/ruby/site_ruby/1.8/puppet/reports/puppet_dashboard.rb',
    }
    require passenger::apache    
  } 

  apache::vhost::file{$dashboard_vhost:
    content => template('puppet/dashboard/apache_vhost.erb'),
  }
}
