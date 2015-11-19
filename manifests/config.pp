class jerakia::config {

  if $::jerakia::manage_config_dir {
    file { $::jerakia::config_dir:
      ensure => directory,
    }
  }

  if $::jerakia::manage_plugin_dir {
    file { [ 
      $::jerakia::plugin_dir,
      "${::jerakia::plugin_dir}/jerakia",
      "${::jerakia::plugin_dir}/jerakia/lookup",
      "${::jerakia::plugin_dir}/jerakia/lookup/plugin",
    ]: 
      ensure => directory,
    }
  }

  if $::jerakia::manage_policy_dir {
    file { $::jerakia::policy_dir:
      ensure => directory,
    }
  }

  if $::jerakia::manage_log_dir {
    $log_dir = inline_template('<%= scope["::jerakia::logfile"].split(/\//)[0...-1].join("/") %>')
    file { $log_dir:
      ensure => directory,
    }
  }

  file { $::jerakia::logfile:
    ensure => file,
    owner  => $::jerakia::logfile_owner,
    group  => $::jerakia::logfile_group,
  }

  file { "${::jerakia::config_dir}/jerakia.yaml":
    ensure  => file,
    content => template('jerakia/jerakia.yaml.erb'),
    replace => $::jerakia::config_replace,
  }



}

