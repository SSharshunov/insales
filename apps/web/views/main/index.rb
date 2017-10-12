module Web::Views::Main
  class Index
    include Web::View

    def store_cities
      url = "https://api.exline.systems/public/v1/regions/origins?country=KZ"
      JSON.load(open(Addressable::URI.parse(url).normalize.to_s))['regions']
      .map {|v| [ v['title'], v['id'] ] }
    end

    def deliveries
      InsalesApi::DeliveryVariant.all
    end

    def create_deliveries
      #@account = AccountRepository.find(2) insales_id=454613
      #account = AccountRepository.new.account_by_insale_id 454613#params[:insales_id]
      #.new.where(insales_id: params[:insales_id]).limit(1)
      ['standard', 'express'].map { |v|
        InsalesApi::DeliveryVariant.new(
         :title => "Курьер Exline #{v}",
         :description => "ExLine - линия надежной доставки!",
         :type => "DeliveryVariant::External",
         :url => "http://rails.echelonsystems.ru/deliveries/#{v}/id/#{params[:insales_id]}.json",
         :javascript => "",
         :customer_pickup => false,
         :add_payment_gateways => true #,
         # :delivery_locations =>
         #  {
         #    "city": nil,
         #    "country": "KZ",
         #    "region": nil
         #  }
        ).save
      }
    end
  end
end
