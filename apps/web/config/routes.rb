# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

post '/main', to: 'main#update'
get '/main', to: 'main#index'
get '/uninstall', to: 'insales_app#uninstall'
get '/install', to: 'insales_app#install'

root to: 'home#index'

