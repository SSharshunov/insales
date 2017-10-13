require 'open-uri'
require "addressable/uri"
module Api::Controllers::Deliveries
  class Calc
    include Api::Action
    accept :json
    expose :error, :price, :callback #:accounts,

    API_ROOT_URL = 'https://api.exline.systems/public/v1/'
    API_REGIONS_URL = "#{API_ROOT_URL}regions/"

    def get_json url
      JSON.load(open(Addressable::URI.parse(API_ROOT_URL + url).normalize.to_s))
    end

    def pricing_policy
      if @account.pricing_policy != 'default'
        "&pricing_policy=#{@account.pricing_policy}"
      else
        ''
      end
    end

    def load_account id
      #Account.find_by(insales_id: id)
      AccountRepository.new.account_by_insale_id(id).first
    end

    def call(params)
      self.format = :javascript
      #@accounts = AccountRepository.new.all
      puts params[:service]
      @account = load_account params[:insales_id]
      # puts @acc.store_city_id
      service = params[:service] || "standard"
      p = pricing_policy
      # #p = ''
      icity = @account.store_city_id
      #icity = @account["store_city_id"] #.store_city_id

      if icity != 0 # && !icity.nil?
        #if params[:city].nil?
        #puts params[:city]
        url = "regions/destination?title=#{params[:city]}"
        data = get_json url
        puts url
        if data['meta']['total'] != 0
          dcity =  data["regions"].first["id"]

          #logger.warn("dump dcity " + dcity.inspect)
          #render :json => dcity, :callback => params['callback']
        else
          data = nil
          @error = "Невозможно доставить в данный город"
          #render :json => { error: "Невозможно доставить в данный город" },
          #  :callback => params['callback']
        end
      end

      if icity != 0 && !dcity.nil?
        url = "calculate?origin_id=#{icity}&destination_id=#{dcity}&weight=#{params[:weight]}&service=#{service}#{p}"

        data = get_json url
        #dcity =  data["regions"].first["id"]
        #render :json => data["calculation"]
        @price = data["calculation"]["price"] + data["calculation"]["fuel_surplus"]
        #render :json => { error: "Ориентировочная доставка #{data["calculation"]["human_range"]}",
        #  delivery_price: price }, :callback => params['callback']
        # @out_data = { error: "Ориентировочная доставка #{data["calculation"]["human_range"]}",
        #  delivery_price: price, :callback => params[:callback] }
        @error = "Ориентировочная доставка #{data['calculation']['human_range']}"

        #@out_data = "#{params[:callback]}({error: #{error}, delivery_price: #{price}})"
#jQuery16204684495358521503_1361805225262({error: 'My text message', delivery_price: 100})
        # @out_data = {:hello => "goodbye"}
        #@out_data = {error: error}.to_json

        #raw {hello: 'world'}.to_json
      end
      @callback = params[:callback]
      #@data = @account
    end
  end
end
