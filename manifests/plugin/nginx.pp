define collectd::plugin::nginx (
  $url = 'UNSET'
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  if $::osfamily == 'Redhat' {
    package { 'collectd-nginx':
      ensure => $ensure,
    }
  }

  file { "nginx.conf":
    ensure    => $ensure,
    path      => "${conf_dir}/nginx.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/nginx.conf.erb'),
    notify    => Service['collectd']
  }
}
