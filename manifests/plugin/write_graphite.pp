class collectd::plugin::write_graphite (
  $graphitehost = 'localhost',
  $storerates   = false,
  $graphiteport = '2003',
  $ensure       = present,
  $prefix       = 'collectd.'
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  $graphitename = regsubst($graphitehost, '(\.)', '_', 'G')

  file { "write_graphite_${graphitename}.conf":
    ensure    => $collectd::plugin::write_graphite::ensure,
    path      => "${conf_dir}/write_graphite_${graphitename}.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/write_graphite.conf.erb'),
    notify    => Service['collectd'],
  }
}
