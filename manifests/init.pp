# Class: ncpa
# ===========================
#
# Manages Nagios Cross-Platform Agent on RedHat family machines
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `community_string`
# The community_string that the agent will use.
#
# Authors
# -------
#
# Ger Apeldoorn <info@gerapeldoorn.nl>
#
# Copyright
# ---------
#
# Copyright 2017 Ger Apeldoorn, unless otherwise noted.
#
class ncpa (
  $community_string,
  $version = 'installed',
  $rpmrepo_url = $ncpa::params::rpmrepo_url,
  ) inherits ncpa::params {

  ensure_resource( 'package', 'nagios-repo', {
    'ensure'   => $version,
    'source'   => $rpmrepo_url,
    'provider' => 'rpm',
  })

  service { ['ncpa_listener', 'ncpa_passive']:
    ensure => running,
    enable => true,
  }

  package { 'ncpa':
    ensure  => installed,
    require => Package['nagios-repo'],
  }

  file { '/usr/local/ncpa/etc/ncpa.cfg':
    ensure  => file,
    mode    => '0644',
    owner   => 'nagios',
    group   => 'nagios',
    content => epp('ncpa/ncpa.cfg.epp', { 'community_string' => $community_string }),
    notify  => Service['ncpa_listener', 'ncpa_passive'],
  }

}
