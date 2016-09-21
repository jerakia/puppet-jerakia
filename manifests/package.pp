# Private class for installing Jerakia package
class jerakia::package {

  if $::jerakia::install_package {
    package { $::jerakia::package_name:
      ensure            => $::jerakia::package_version,
      provider          => $::jerakia::package_provider,
      install_options   => $::jerakia::package_install_options,
      uninstall_options => $::jerakia::package_uninstall_options,
    }
  }
}
