class jerakia::package {

  if $::jerakia::install_package {
    package { $::jerakia::package_name:
      ensure   => $::jerakia::package_version,
      provider => $::jerakia::package_provider,
    }
  }
}
