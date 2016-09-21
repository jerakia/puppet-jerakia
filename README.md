# jerakia


## Introduction 

This is a puppet module to manage [Jerakia](http://jerakia.io), a data lookup tool.

Jerakia can be used as a hiera backend, or plugged directly into Puppet as a data_binding terminus.

Jerakia is a pluggable hierarchical data lookup engine.  It is not a database, Jerakia itself does not store any data but rather gives a single point of access to your data via a variety of back end data sources.   Jerakia is inspired by Hiera, and can be used a drop in replacement. Hiera itself is a good tool, however it suffers from some degree of limitation in its architecture that makes solving complex edge cases a challenge. Jerakia is an attempt at a different way of approaching data lookup management.  Jerakia started out as a prototype experiment to replace hiera in order to solve a number of complicated requirements for a particular project, over time it matured a bit and we decided to open source it and move it towards a standalone data lookup system.

For more information on Jerakia, visit:

* [The official website - jerakia.io](http://jerakia.io)
* [Blog post part 1: Solving real world problems with Jerakia](http://www.craigdunn.org/2015/09/solving-real-world-problems-with-jerakia/)
* [Blog post part 2: Extending Jerakia with lookup plugins](http://www.craigdunn.org/2015/09/extending-jerakia-with-lookup-plugins/)

## Configuring with Puppet

### Quick start

For a very quick working set up you can configure Jerakia with all the defaults, and install a default lookup policy

```puppet
    class { '::jerakia': }
 
    jerakia::policy { 'default': }
```

After running puppet, populate some data and look up from the command line

```
    # mkdir /var/lib/jerakia
    # cat <<EOF > /var/lib/jerakia/common.yaml
    > ---
    > foo: hello world
    EOF
    
    # jerakia -k foo
    hello world
    
```

## Class: jerakia

The `jerakia` class supports the following optional parameters

* `package_install_options` : array of install options for package (default: undef)
* `package_name` : name of the package to install (default: jerakia)
* `package_provider`: provider to use (default: gem)
* `package_uninstall_options` : array of uninstall options for package (default: undef)
* `package_version`: package version (default: latest)
* `install_package`: If set to false, don't manage the package (default: true)
* `config_dir`: Location of the configuration directory
* `config_replace`: If set to false, will not overwrite the config after creation
* `policy_dir`: Location of the policy directory
* `manage_config_dir`: Create/manage the config dir (default: true)
* `manage_plugin_dir`: Create/manage the plugin dir (default: true)
* `manage_policy_dir`: Create/manage the policy dir (default: true)
* `manage_log_dir`: Create/manage the parent directory of the logfile path (default: true)
* `plugin_dir`: Location of the plugins
* `logfile`: Path to the logfile
* `log_level`: Loglevel (default: info)
* `logfile_owner`: Logfile owner (default: puppet)
* `logfile_group`: Logfile group (default: puppet)
* `logfile_mode`: Logfile mode (default: 0644)
* `private_key`: If using eyaml, the path to the private key (default: empty)
* `public_key` If using eyaml, the path to the public key (default: empty)
* `enable_schemas`: Enable or disable schemas by setting true or false
* `schema_opts`: A hash containing schema override options
* `plugin_opts`: A hash of options to be passed to plugins

### Examples:


```puppet
class { 'jerakia': }
```

```puppet
class { 'jerakia':
  schema_opts => {
    "docroot" => "/var/lib/jerakia/data/_schema",
  }
}
```

```puppet
class { 'jerakia':
  plugin_opts => {
    "my_plugin" => {
      "param" => "value",
    },
  }
}
```


    
## Define type: jerakia::policy

Jerakia policies are written in Ruby DSL and reside under the `$policy_dir` directory.  The module provides a helper defined type for managing policies.  The contents of the policy file can be sourced from any Puppet module by providing the `template` parameter.  All data in the `params` parameter will be passed to the template.  An example quick start default policy is provided and can be enabled using:

```puppet
jerakia::policy { 'default': }
```

You can injecty our own templates and data into a policy by overriding the defaults. eg:

```puppet
jerakia::policy { 'default':
  template => 'mymodule/jerakia.erb',
  params   => {
    'docroot' => '/var/lib/jerakia',
    'mydata'  => 'myvalue',
  }
}
```
The contents of the `params` hash is arbitry and entirely dependant on what your template looks for.  See `templates/default_policy.erb` for an example

The `jerakia::policy` type supports the following parameters

* `policy_dir`: The location of policy files, defaults to the value defined in `jerakia::policy_dir`
* `params`: A hash of parameters to be consumed by the policy template
* `template`: The template to use (default:  jerakia/default_policy.erb)
* `replace`: If set to false then Puppet will not overwrite the policy file after creation (default: true)



