define collectd::plugin::librato (
  $prefix = 'collectd',
  $apitoken = undef,
  $ensure = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  $email = $name
  $emailname = regsubst($name, '([\@\.])', '_', 'G')

  if $apitoken == undef {
    fail('need to define apitoken in collectd::plugin::librato')
  }

  exec { '/usr/bin/wget -O /usr/lib/collectd/collectd-librato.py https://github.com/librato/collectd-librato/raw/master/lib/collectd-librato.py':
    creates => '/usr/lib/collectd/collectd-librato.py',
    require => Package[$collectd::params::package]
  }

  file { "librato_${emailname}.conf":
    ensure    => $collectd::plugin::write_graphite::ensure,
    path      => "${conf_dir}/librato_${emailname}.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/librato.conf.erb'),
    notify    => Service['collectd'],
  }

}
