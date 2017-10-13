module Web::Controllers::Main
  class Update
    include Web::Action

    expose :account

    params do
      required(:account).schema do
        required(:title).filled(:str?)
        required(:author).filled(:str?)
      end
    end

    def call(params)
      if params.valid?
        repository = AccountRepository.new
        #@account = AccountRepository.new.create(params[:book])
        @account = repository.update(params[:insales_id], title: "Hanami Book")

        redirect_to '/books'
      else
        self.status = 422
      end
    end
  end
end
