require 'spec_helper'
require_relative '../../../../apps/web/controllers/deliveries/calc'

describe Web::Controllers::Deliveries::Calc do
  let(:action) { Web::Controllers::Deliveries::Calc.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
