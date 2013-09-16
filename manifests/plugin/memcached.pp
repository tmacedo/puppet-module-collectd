define collectd::plugin::memcached (
  $port    = '11211'
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  $hostname = $name

  file { "memcached_${hostname}.conf":
    ensure    => $ensure,
    path      => "${conf_dir}/memcached_${hostname}.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/memcached.conf.erb'),
    notify    => Service['collectd']
  }

}
