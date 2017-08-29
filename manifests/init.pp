# Class: ncpa
# ===========================
#
# Full description of class ncpa here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'ncpa':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class ncpa (
  $community_string,
  ) inherits ncpa::params {

  ensure_resource( 'package', 'nagios-repo', {
    'ensure'   => 'installed',
    'source'   => $rpmrepo_url,
    'provider' => 'rpm',
  })

  package { 'ncpa':
    ensure  => installed,
    require => Package['nagios-repo'],
  }

  file { '/usr/local/ncpa/etc/ncpa.cfg':
    ensure => file,
    mode   => '0644',
    owner  => 'nagios',
    group  => 'nagios',
    content => epp('ncpa/ncpa.cfg.epp', { 'community_string' => $community_string })
  }

}
