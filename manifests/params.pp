# == Class: ncpa::params
#
class ncpa::params {
  case $::os['family'] {
    'RedHat': {
      case $::os['release']['major']{
        '7': {
          $rpmrepo_url = 'https://repo.nagios.com/nagios/7/nagios-repo-7-3.el7.noarch.rpm'
        }
        '6': {
          $rpmrepo_url = 'https://repo.nagios.com/nagios/6/nagios-repo-6-3.el6.noarch.rpm'
         }
        '5': {
          $rpmrepo_url = 'https://repo.nagios.com/nagios/5/nagios-repo-5-2.el5.noarch.rpm'
        }
      }
    }
    default: {
      fail("Sorry, ${::os['family']} is not supported.")
    }
  }
}
