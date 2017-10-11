require 'spec_helper'

describe Account do
  it 'can be initialised with attributes' do
    account = Account.new(
      insales_subdomain: 'myshop-eo558.myinsales.ru',
      password:          'xxxxxxxxxxxxxxxxxxxxxxxxx',
      insales_id:        454643,
      delivery_id:       0,
      store_city_id:     0,
      pricing_policy:    'default',
      )
    account.insales_subdomain.must_equal 'myshop-eo558.myinsales.ru'
    account.password.must_equal 'xxxxxxxxxxxxxxxxxxxxxxxxx'
    account.insales_id.must_equal 454643
    account.delivery_id.must_equal 0
    account.store_city_id.must_equal 0
    account.pricing_policy.must_equal 'default'

  end
end
