require 'open-uri'
require "addressable/uri"

module Web::Controllers::Main
  class Index
    include Web::Action

    expose :main_account

    def call(params)
      @ins_id = params[:insales_id]
      repository = AccountRepository.new
      @main_account = repository.account_by_insale_id(@ins_id).first
      if @main_account.delivery_id == '0'
        puts 'its null'
        Insales::MyApp.configure_api(params[:shop], @main_account.password)
        d = create_deliveries.inject([]){|a,x| a << x.id }.to_json

        entity = Account.new(
          insales_subdomain: @main_account.insales_subdomain,
          password: @main_account.password,
          insales_id: @main_account.insales_id,
          delivery_id: d,
          store_city_id: @main_account.store_city_id,
          pricing_policy: @main_account.pricing_policy
        )
        user = repository.update(@main_account.id, entity)
      end
    end

    def create_deliveries
      ['standard', 'express'].map { |v|
        dv = InsalesApi::DeliveryVariant.new(
         :title => "Курьер Exline #{v}",
         :description => "ExLine - линия надежной доставки!",
         :type => "DeliveryVariant::External",
         :url => "#{ENV["SERVER_URL"]}/api/deliveries/#{v}/id/#{params[:insales_id]}.json",
         :javascript => "",
         :customer_pickup => false,
         :add_payment_gateways => true
        )
        dv.save
        dv
      }
    end
  end
end
