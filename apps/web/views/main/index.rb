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

    def form
      url = "/main?insales_id=#{params[:insales_id]}&shop=#{params[:shop]}&user_email=#{params[:shop]}&user_id=#{params[:user_id]}"
      form_for :main_account, url, {
        store_city_id: main_account.store_city_id,
        pricing_policy: main_account.pricing_policy
      } do
        hidden_field :id, value: main_account.id
        h3 'Город отправки (местонахождение склада)'
        div class: 'form-group' do
        #  label      :store_city_id
          select     :store_city_id,
            store_cities,
            options: { prompt: 'Select a store', selected: main_account.store_city_id },
            class: "form-control"
        end

        h3 'Номер договора с компанией ExLine'
        div class: 'form-group' do
        #  label      :pricing_policy
          text_field :pricing_policy, class: "form-control", value: main_account.pricing_policy
        end

        div class: 'controls' do
          submit 'Update', class: "btn btn-default"
        end
      end
    end
  end
end
