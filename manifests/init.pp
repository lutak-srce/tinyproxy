# Class: tinyproxy
#
# This modules installs tinyproxy
#
class tinyproxy (
  $port                 = '8888',
  $listen               = '',
  $bind                 = '',
  $timeout              = '600',
  $maxclients           = '100',
  $minspareservers      = '5',
  $maxspareservers      = '20',
  $startservers         = '10',
  $maxrequestsperchild  = '0',
  $allow                = [ '127.0.0.1' ],
  $viaproxyname         = 'tinyproxy',
  $filter               = undef,
  $filter_source        = undef,
  $filter_urls          = false,
  $filter_extended      = false,
  $filter_casesensitive = false,
  $filter_default_deny  = false,
  $connectport          = [ '443', '563' ],
) {

  File {
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['tinyproxy'],
    notify  => Service['tinyproxy'],
  }

  package { 'tinyproxy':
    ensure  => present,
  }

  file { '/etc/tinyproxy/tinyproxy.conf':
    content => template('tinyproxy/tinyproxy.conf.erb'),
  }

  if ( $filter != undef ) {
    file { '/etc/tinyproxy/filter':
      path   => $filter,
      source => $filter_source,
    }
  }

  service { 'tinyproxy':
    ensure   => running,
    enable   => true,
    provider => 'redhat',
  }

}
