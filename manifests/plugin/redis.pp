define collectd::plugin::redis (
  $port    = '6379',
  $verbose = 'false'
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  $hostname = $name

  exec { 'download collectd-redis':
    command => '/usr/bin/wget -O /usr/lib/collectd/redis_info.py https://github.com/powdahound/redis-collectd-plugin/raw/master/redis_info.py',
    creates => '/usr/lib/collectd/redis_info.py',
    require => Package[$collectd::params::package],
    notify  => Service['collectd']
  }


  file { "redis_${hostname}.conf":
    ensure    => $ensure,
    path      => "${conf_dir}/redis_${hostname}.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/redis.conf.erb'),
    notify    => Service['collectd'],
    require   => Exec['download collectd-redis']
  }

}
