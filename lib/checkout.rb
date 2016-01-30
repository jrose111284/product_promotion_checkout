require 'json'
class Checkout

  def initialize(products_json)
    @products = JSON.parse(File.read(products_json))
    @order = []
    # require 'byebug'
    # byebug
  end

  def scan(barcode)
    fail "please enter string value" unless barcode.is_a? String
    fail "cant find this product" unless @products.has_key?(barcode)
    @order << barcode
  end



  def total
    total_price = 0.0
    @order.each do |product_code|
      total_price += @products[product_code]["product_price"]
    end
    total_price
  end
end
