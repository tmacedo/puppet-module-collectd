# Usage:
# e.g.
# collectd::plugin::tail { 'nginx':
#   file => '/var/log/nginx/access.log',
#   match => [ { 'regex'  => '.*',
#                'dstype' => 'CounterInc',
#                'type'   => 'counter',
#                'name'   => 'requests' },
#              { 'regex'  => '.*HTTP/1.[0-9]\" 2[0-9]{1,2} .*',
#                'dstype' => 'CounterInc',
#                'type'   => 'counter',
#                'name'   => '200' },
#              { 'regex'  => '.*HTTP/1.[0-9]\" 3[0-9]{1,2} .*',
#                'dstype' => 'CounterInc',
#                'type'   => 'counter',
#                'name'   => '300' },
#              { 'regex'  => '.*HTTP/1.[0-9]\" 4[0-9]{1,2} .*',
#                'dstype' => 'CounterInc',
#                'type'   => 'counter',
#                'name'   => '400' },
#              { 'regex'  => '.*HTTP/1.[0-9]\" 5[0-9]{1,2} .*',
#                'dstype' => 'CounterInc',
#                'type'   => 'counter',
#                'name'   => '500' } ]
# }

define collectd::plugin::tail (
  $file = undef,
  $match = { }
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  if $file == undef {
    fail("collectd::plugin::tail needs a filename defined")
  }

  if !is_array($match) {
    fail("collectd::plugin::tail match must be an array of hashes")
  }

  file { "tail_${name}.conf":
    ensure    => $ensure,
    path      => "${conf_dir}/tail_${name}.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/tail.conf.erb'),
    notify    => Service['collectd'],
  }


}
