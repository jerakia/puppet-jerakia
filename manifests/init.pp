# == Class: jerakia
#
# Full description of class jerakia here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'jerakia':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class jerakia (
  $package_name      = $::jerakia::params::package_name,
  $package_provider  = $::jerakia::params::package_provider,
  $package_version   = $::jerakia::params::package_version,
  $install_package   = $::jerakia::params::install_package,
  $config_dir        = $::jerakia::params::config_dir,
  $config_replace    = $::jerakia::params::config_replace,
  $policy_dir        = $::jerakia::params::policy_dir,
  $manage_config_dir = $::jerakia::params::manage_config_dir,
  $manage_plugin_dir = $::jerakia::params::manage_plugin_dir,
  $manage_policy_dir = $::jerakia::params::manage_policy_dir,
  $manage_log_dir    = $::jerakia::params::manage_log_dir,
  $plugin_dir        = $::jerakia::params::plugin_dir,
  $logfile           = $::jerakia::params::logfile,
  $log_level          = $::jerakia::params::log_level,
  $logfile_owner     = $::jerakia::params::logfile_owner,
  $logfile_group     = $::jerakia::params::logfile_group,
  $private_key       = $::jerakia::params::private_key,
  $public_key        = $::jerakia::params::public_key,
  ) inherits jerakia::params {

  class { '::jerakia::package': } ->
  class { '::jerakia::config': }

  contain 'jerakia::package'
  contain 'jerakia::config'
}
