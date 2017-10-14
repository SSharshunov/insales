module Web::Controllers::Main
  class Update
    include Web::Action

    expose :main_account

    params do
      required(:main_account).schema do
        required(:store_city_id).filled(:str?)
        required(:pricing_policy).filled(:str?)
      end
    end

    def call(params)
      puts params.raw["insales_id"].inspect
      if params.valid?
        repository = AccountRepository.new
        @main_account = repository.account_by_insale_id(params.raw["insales_id"]).first
        entity = Account.new(
          insales_subdomain: @main_account.insales_subdomain,
          password: @main_account.password,
          insales_id: @main_account.insales_id,
          delivery_id: @main_account.delivery_id,
          store_city_id: params.raw["main_account"]["store_city_id"],
          pricing_policy: params.raw["main_account"]["pricing_policy"]
        )
        user = repository.update(@main_account.id, entity)
        redirect_to "/main?insales_id=#{params.raw["insales_id"]}&shop=#{params.raw["shop"]}&user_email=#{params.raw["user_email"]}&user_id=#{params.raw["user_id"]}"
      else
        self.status = 422
      end
    end
  end
end
