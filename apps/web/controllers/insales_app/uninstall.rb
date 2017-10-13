module Web::Controllers::InsalesApp
  class Uninstall
    include Web::Action

    def call(params)
      raise "Fail to uninstall" unless uninstall
    end

    def uninstall
      shop = Insales::MyApp.prepare_domain params[:shop]
      repository = AccountRepository.new.find_by_insales_subdomain(shop)
      account = repository.first
      if repository.count != 0
        puts "exists"
        if (account.insales_subdomain == params[:shop]) and
           (account.password == params[:token])
            puts "account identified"
            if account.delivery_id != '0'
              Insales::MyApp.configure_api(params[:shop], account.password)
              dv = account.delivery_id.tr('[]', '').split(',').map(&:to_i)
              delete_deliveries dv
            end
           AccountRepository.new.delete(account.id)
        end
      end
      return true
    end

    def password_by_token(token)
      InsalesApi::Password.create(Insales::MyApp.api_secret, token)
    end

    def delete_deliveries delivery_ids
      delivery_ids.map { |v|
        dv = InsalesApi::DeliveryVariant.find(v)
        dv.destroy
      }
    end

  end
end
