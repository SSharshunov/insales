module Web::Controllers::Deliveries
  class Calc
    include Web::Action

    API_ROOT_URL = 'https://api.exline.systems/public/v1/'
    API_REGIONS_URL = "#{API_ROOT_URL}regions/"

    def get_json url
      JSON.load(open(Addressable::URI.parse(API_ROOT_URL + url).normalize.to_s))
    end

    def pricing_policy
      if @acc.pricing_policy != 'default'
        "&pricing_policy=#{@acc["pricing_policy"]}"
      else
        ''
      end
    end

    def load_account id
      #Account.find_by(insales_id: id)
      AccountRepository.new.account_by_insale_id(id).first
    end

    def call(params)
      @acc = load_account params[:insales_id]
      puts @acc.store_city_id
      service = params[:service] || "standard"
      p = pricing_policy
      #p = ''
      icity = @acc.store_city_id
      #icity = @acc["store_city_id"] #.store_city_id

      if icity != 0 # && !icity.nil?
        #if params[:city].nil?
        url = "regions/destination?title='#{params[:city]}'"
        data = get_json url
        if data['meta']['total'] != 0
          dcity =  data["regions"].first["id"]
          logger.warn("dump dcity " + dcity.inspect)
          #render :json => dcity, :callback => params['callback']
        else
          data = nil
          render :json => { error: "Невозможно доставить в данный город" },
            :callback => params['callback']
        end
      end

      if icity != 0 && !dcity.nil?
        url = "calculate?origin_id=#{icity}&destination_id=#{dcity}&weight=#{params[:weight]}&service=#{service}#{p}"

        data = get_json url
        #dcity =  data["regions"].first["id"]
        #render :json => data["calculation"]
        price = data["calculation"]["price"] + data["calculation"]["fuel_surplus"]
        render :json => { error: "Ориентировочная доставка #{data["calculation"]["human_range"]}",
          delivery_price: price }, :callback => params['callback']
      end

    end
  end
end
