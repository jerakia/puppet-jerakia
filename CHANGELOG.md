## 1.2.0

* Bugfix: Backend now returns `context.not_found` instead of `nil` when a lookup returns no data.
* Feature: By default the module will now use Puppets interpolate feature when doing lookups. This negates the need to use the `strsub` output filter.  This can be disabled by using the option `interpolate: false` in `hiera.yaml`


## 1.1.0

* Added the Hiera 5 data provider function [See docs](http://jerakia.io/integration/puppet)


# 1.0.0

* Added `package_install_options` and `package_uninstall_options` attributes

### 0.2.1

* Added logfile_mode parameter

## 0.2.0

* Added schema and plugin options to jerakia.yaml

### 0.1.2

* Remove fully qualified contain statements for Puppet 3.6 compatibility (PUP-1597)

### 0.1.1

* No functional changes, metadata improvements for Puppet Forge
