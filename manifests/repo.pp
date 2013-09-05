class collectd::repo {

  if $collectd::version == '5' {
    if $::operatingsystem == 'Ubuntu' {
      if $::lsbdistcodename == 'precise' {
        apt::ppa { 'ppa:vbulax/collectd5': }
      }
    }
  }

}
