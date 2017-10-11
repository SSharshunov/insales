require 'spec_helper'
require_relative '../../../../apps/web/controllers/main/index'

describe Web::Controllers::Main::Index do
  let(:action) { Web::Controllers::Main::Index.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
