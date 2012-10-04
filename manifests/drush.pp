class drush () {
  package { 'php5-cli':
    ensure => installed,
  }

  package { 'drush':
    ensure => installed,
    require => Package['php5-cli'],
  }
}
