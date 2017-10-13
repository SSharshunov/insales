module Web::Controllers::InsalesApp
  class Install
    include Web::Action

    def call(params)
      raise "Fail to install" unless install?
    end

    def install?
      shop = Insales::MyApp.prepare_domain params[:shop]
      if AccountRepository.new.find_by_insales_subdomain(shop).count == 0
        AccountRepository.new.create(
          insales_subdomain: params[:shop],
          password:          password_by_token(params[:token]),
          insales_id:        params[:insales_id],
          delivery_id:       0,
          store_city_id:     0,
          pricing_policy:    'default'
        )
      end
      return true
    end

    def password_by_token(token)
      InsalesApi::Password.create(Insales::MyApp.api_secret, token)
    end
  end
end
