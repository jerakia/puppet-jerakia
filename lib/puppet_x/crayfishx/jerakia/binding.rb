# An experimental Puppet 4 environment data provider to hook into Jerakia
# 
require 'puppet_x'
require 'jerakia'

module PuppetX::Crayfishx
  module Jerakia
    class Binding < Puppet::Plugins::DataProviders::EnvironmentDataProvider

      def initialize
        @jerakia = ::Jerakia.new()
      end

      def lookup(key, invocation, merge)
        # Jerakia uses schemas to define lookup options, we could interrogate the
        # schema and return it as "lookup_options" here, but I really don't see
        # the point since the lookup datasource will be passed the right options
        # from the schema, so for now, we'll just treat Puppet's requests for 
        # lookup_options as white noise and do nothing
        return {} if key == 'lookup_options'


        metadata = invocation.scope.to_hash
        namespace = []
       
        case merge.configuration
        when 'first'
          lookup_type = :first
          merge_type  = :none
        when 'unique'
          lookup_type = :cascade
          merge_type  = :array
        when 'hash'
          lookup_type = :cascade
          merge_type  = :hash
        when 'deep'
          lookup_type = :cascade
          merge_type  = :deep_hash
        end
 

        if key.include?('::')
          lookup_key = key.split('::')
          key = lookup_key.pop
          namespace = lookup_key
        end

        request = ::Jerakia::Request.new(
          :key         => key,
          :namespace   => namespace,
          :metadata    => metadata,
          :lookup_type => lookup_type,
          :merge       => merge_type
        )

        answer = @jerakia.lookup(request)
        answer.payload 
      end
    end
  end
end
