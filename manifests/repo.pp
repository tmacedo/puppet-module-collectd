class collectd::repo {

  if $collectd::version == '5' {
    if $::operatingsystem == 'Ubuntu' {
      apt::ppa { 'ppa:vbulax/collectd5': }
    }
  }

}
