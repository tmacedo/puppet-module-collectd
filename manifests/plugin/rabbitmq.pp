define collectd::plugin::rabbitmq (
  $ensure = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  $vhost = regsubst($name, '/', '_', 'G')

  file { '/usr/lib/collectd/rabbitmq_info.py':
    source  => 'puppet:///modules/collectd/rabbitmq_info.py',
    ensure  => $ensure,
    require => Package[$collectd::params::package],
    notify  => Service['collectd']
  }

  file { "rabbitmq_${vhost}.conf":
    ensure    => $ensure,
    path      => "${conf_dir}/rabbitmq_${vhost}.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/rabbitmq.conf.erb'),
    notify    => Service['collectd'],
    require   => File['/usr/lib/collectd/rabbitmq_info.py']
  }

}
