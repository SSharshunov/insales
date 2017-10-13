require 'open-uri'
require "addressable/uri"

module Web::Controllers::Main
  class Index
    include Web::Action

    expose :account
    def call(params)
      @ins_id = params[:insales_id]
      #repository = AccountRepository.new
      #@account = AccountRepository.new.account_by_insale_id(@ins_id).first
      AccountRepository.new.update(@ins_id, store_city_id: 1)
      # if @account.delivery_id == '0'
      #   puts 'its null'
      #   d = [ 1234615, 1234616 ].inject([]){|a,x| a << x }.to_json

      #   #d = create_deliveries.map {|a| a.id}
      #   #d = create_deliveries.inject([]){|a,x| a << x.id }
      #   puts d

      #   AccountRepository.new.update(@ins_id, delivery_id: d)
      #   #@account.delivery_id = d
      #   #@account = repository.update(ins_id, delivery_id: d)
      # else
      #   puts 'not null'
      # end
      #AccountRepository.new.where(:insales_id params[:insales_id]).first
      #puts @data
      # @greeting = "Hello"
    end

    def create_deliveries
      #@account = AccountRepository.find(2) insales_id=454613
      #account = AccountRepository.new.account_by_insale_id 454613#params[:insales_id]
      #.new.where(insales_id: params[:insales_id]).limit(1)
      ['standard', 'express'].map { |v|
        dv = InsalesApi::DeliveryVariant.new(
         :title => "Курьер Exline #{v}",
         :description => "ExLine - линия надежной доставки!",
         :type => "DeliveryVariant::External",
         :url => "http://rails.echelonsystems.ru/api/deliveries/#{v}/id/#{params[:insales_id]}.json",
         :javascript => "",
         :customer_pickup => false,
         :add_payment_gateways => true #,
         # :delivery_locations =>
         #  {
         #    "city": nil,
         #    "country": "KZ",
         #    "region": nil
         #  }
        )
        dv.save
        dv
      }
    end
  end
end
