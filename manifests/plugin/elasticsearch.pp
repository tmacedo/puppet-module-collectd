define collectd::plugin::elasticsearch (
  $verbose = 'false',
  $ensure = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  $cluster = $name

  exec { 'download collectd-elasticsearch':
    command => '/usr/bin/wget -O /usr/lib/collectd/elasticsearch.py https://github.com/phobos182/collectd-elasticsearch/raw/master/elasticsearch.py',
    creates => '/usr/lib/collectd/elasticsearch.py',
    require => Package[$collectd::params::package],
    notify  => Service['collectd']
  }

  file { "elasticsearch_${cluster}.conf":
    ensure    => $ensure,
    path      => "${conf_dir}/elasticsearch_${cluster}.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/elasticsearch.conf.erb'),
    notify    => Service['collectd'],
    require   => Exec['download collectd-elasticsearch']
  }

}
