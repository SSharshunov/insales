module Web::Views::Main
  class Index
    include Web::View
    template 'main/index'

    def store_cities
      url = "https://api.exline.systems/public/v1/regions/origins?country=KZ"
      JSON.load(open(Addressable::URI.parse(url).normalize.to_s))['regions']
      .map {|v| [ v['title'], v['id'] ] }
    end

    def deliveries
      InsalesApi::DeliveryVariant.all
    end


  end
end
