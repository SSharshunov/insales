module Insales
  class MyApp < InsalesApi::App
    self.api_key = '4b7ae5a8db624a1299f249c36aa339e9'
    self.api_secret = '9268e059b25c2403afead89b72b82771'
  end

  MyApp.configure_api('myshop-eo558.myinsales.ru', '6f4046723dfaaac9a26907fd8c373381')
end
