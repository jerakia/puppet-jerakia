Puppet::Functions.create_function(:jerakia) do

  begin
    require 'jerakia/client'
  rescue LoadError => e
    raise Puppet::DataBinding::LookupError, "Puppet cannot load the jerakia-client gem"
  end

  dispatch :lookup_key do
    param 'Variant[String, Numeric]', :key
    param 'Hash', :options
    param 'Puppet::LookupContext', :context
  end

  def lookup_key(key, options, context)

    # Jerakia doesn't do anything with lookup_options since all the hierarchy
    # calculations are done remotely, Jerakia schemas should be used to control
    # the lookup and merge strategies for particular keys.
    #
    return {} if key == 'lookup_options'

    jerakia_options = {} 

    options.reject { |k| [ "scope", "policy", "interpolate" ].include?(k) }.each { |k, v|
      jerakia_options[k.to_sym] = v
    }

    scope = options["scope"] || {}
    policy = options["policy"] || :default
    interpolate = options["interpolate"] || true

    jerakia = Jerakia::Client.new(jerakia_options)

    namespace = []

    if key.include?('::')
      lookup_key = key.split('::')
      key = lookup_key.pop
      namespace = lookup_key
    end

    result = jerakia.lookup(key, {
      :namespace => namespace,
      :metadata  => scope,
      :policy    => policy
    })

    if result.is_a?(Hash)
      raise Puppet::DataBinding::LookupError.new("Jerakia data lookup failed", result['message']) unless result['status'] = 'ok'
      if result['payload'].nil?
        context.not_found
      else
        payload = result['payload']
        return context.interpolate(payload) if interpolate
        return payload
      end
    else
      raise Puppet::DataBinding::LookupError.new("Jerakia data lookup failed", "Expected a hash but got a #{result.class}")
    end
  end
end



