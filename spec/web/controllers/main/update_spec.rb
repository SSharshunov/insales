require 'spec_helper'
require_relative '../../../../apps/web/controllers/main/update'

describe Web::Controllers::Main::Update do
  let(:action) { Web::Controllers::Main::Update.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
