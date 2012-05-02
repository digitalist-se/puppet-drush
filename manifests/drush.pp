class drush (
  $tar = 'drush-7.x-4.5.tar.gz'
) {
  package { 'php5-cli':
    ensure => installed,
  }

  exec { 'drush download':
    cwd => '/root',
    command => "/usr/bin/wget http://ftp.drupal.org/files/projects/${tar}",
    creates => "/root/${tar}",
    unless => '/usr/bin/test -d /opt/drush'
  }

  exec { 'drush install':
    cwd => '/opt/',
    command => "/bin/tar xvzf /root/${tar}; /opt/drush/drush",
    creates => '/opt/drush',
    unless => '/usr/bin/test -d /opt/drush',
    require => [Exec['drush download'], Package['php5-cli']],
  }

  file { '/usr/local/bin/drush':
    ensure => '/opt/drush/drush',
  }
}
