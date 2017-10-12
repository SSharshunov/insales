module Web::Controllers::InsalesApp
  class Install
    include Web::Action

    def call(params)
      # if insales_app_class.install(params[:shop], params[:token], params[:insales_id])
      #   head :ok
      # else
      #   raise 'Instalation failed'
      # end
      #@book = BookRepository.new.create(params[:book])
      @account = AccountRepository.new.create(
        insales_subdomain: params[:shop],
        password:          password_by_token(params[:token]),
        insales_id:        params[:insales_id],
        delivery_id:       0,
        store_city_id:     0,
        pricing_policy:    'default'
      )  #.save
    end

    def password_by_token(token)
      InsalesApi::Password.create('9268e059b25c2403afead89b72b82771', token)
    end
  end
end
