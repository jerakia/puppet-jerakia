# Default parameters for Jerakia module
class jerakia::params  {

  $package_name     = 'jerakia'
  $package_provider = 'gem'
  $package_version  = 'latest'

  ## If you are using this module to configure jerakia as a normal
  ## user (eg: specific config in your homedir) then you don't want
  ## to manage the package.
  $install_package  = true

  $config_dir       = '/etc/jerakia'
  $config_replace   = true
  $plugin_dir       = "${config_dir}/lib"
  $policy_dir       = "${config_dir}/policy.d"
  $logfile          = '/var/log/jerakia/jerakia.log'
  $log_level         = 'info'
  $private_key      = ''
  $public_key       = ''
  $manage_config_dir = true
  $manage_plugin_dir = true
  $manage_policy_dir = true
  $manage_log_dir    = true

  ## If we are running this module, we can probably assume that the user
  ## wants to use jerakia with Puppet, so make sure Puppet owns the logfile

  $logfile_owner = 'puppet'
  $logfile_group = 'puppet'
  $logfile_mode  = '0644'



}
