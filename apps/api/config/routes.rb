# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

# get '/deliveries', to: 'deliveries#calc'
get '/deliveries/:service/id/:insales_id(.:format)', to: 'deliveries#calc'
# get '/deliveries', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
