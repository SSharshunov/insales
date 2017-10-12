require 'open-uri'
require "addressable/uri"

module Web::Controllers::Main
  class Index
    include Web::Action

    #expose :account
    def call(params)
      #@account = AccountRepository.new.all
      #puts @data
      # @greeting = "Hello"
    end
  end
end
