require 'spec_helper'
require_relative '../../../../apps/web/controllers/insales_app/uninstall'

describe Web::Controllers::InsalesApp::Uninstall do
  let(:action) { Web::Controllers::InsalesApp::Uninstall.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
