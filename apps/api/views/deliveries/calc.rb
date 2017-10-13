require 'json'
module Api::Views::Deliveries
  class Calc
    include Api::View
    layout false

    def render
      if price.nil?
        _raw "#{callback}({error: '#{error}'})"
      else
        _raw "#{callback}({error: '#{error}', delivery_price: #{price}})"
      end
    end
  end
end
