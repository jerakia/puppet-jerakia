Puppet::Bindings.newbindings('jerakia::default') do

  bind {
    name        'jerakia'
    in_multibind 'puppet::environment_data_providers'
    to_instance  'PuppetX::Crayfishx::Jerakia::Binding'
  }

end
