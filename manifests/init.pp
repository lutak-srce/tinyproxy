# Class: tinyproxy
#
# This modules installs tinyproxy
#
class tinyproxy (
  $port                = '8888',
  $listen              = '',
  $bind                = '',
  $maxclients          = '100',
  $minspareservers     = '5',
  $maxspareservers     = '20',
  $startservers        = '10',
  $maxrequestsperchild = '0',
  $allow               = [ '127.0.0.1' ],
  $connectport         = [ '443', '563' ],
) {

  package { 'tinyproxy':
    ensure  => present,
  }

  file { '/etc/tinyproxy/tinyproxy.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('tinyproxy/tinyproxy.conf.erb'),
    require => Package['tinyproxy'],
    notify  => Service['tinyproxy'],
  }

  service { 'tinyproxy':
    ensure   => running,
    enable   => true,
    provider => 'redhat',
  }

}
