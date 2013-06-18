class collectd::plugin::librato (
  $prefix = 'collectd.',
  $apitoken = undef,
  $email = undef,
  $ensure = present
) {
  include collectd::params

  if $apitoken == undef {
    fail('need to define apitoken in collectd::plugin::librato')
  }

  if $email == undef {
    fail('need to define email in collectd::plugin::librato')
  }

  exec { '/usr/bin/wget -O /usr/lib/collectd/librato.py https://github.com/librato/collectd-librato/raw/master/lib/collectd-librato.py':
    creates => '/usr/lib/collectd/librato.py',
  }

  file { "librato.conf":
    ensure    => $collectd::plugin::write_graphite::ensure,
    path      => "${conf_dir}/librato.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/librato.conf.erb'),
    notify    => Service['collectd'],
  }

}
