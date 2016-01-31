require 'json'
class Checkout

  def initialize(products_json, promotions_json)
    @products = JSON.parse(File.read(products_json))
    @promotions = JSON.parse(File.read(promotions_json))
    @order = []
  end

  def scan(barcode)
    fail "please enter string value" unless barcode.is_a? String
    fail "cant find this product" unless @products.has_key?(barcode)
    @order << barcode
  end

  def total
    total_price = 0.0
    @order.each do |product_code|
    if product_on_promotion(product_code) && product_fulfulls_promotion(product_code)
      total_price += @promotions["product_promotions"][product_code]["discount_price"]
    else
      total_price += @products[product_code]["product_price"]
    end
    end
    apply_total_price_promotion(total_price).round(2)
  end

  private

  def apply_total_price_promotion(total_price)
    correct_promotion = find_correct_total_price_promotion(total_price)
    if correct_promotion
      discount_percentage = @promotions["total_price_promotions"][correct_promotion.to_s]["discount_percentage"]
      return total_price -= (total_price * discount_percentage)
    end
    total_price
  end

  def find_correct_total_price_promotion(total_price)
    available_promotions = []
    correct_promotion = false
    @promotions["total_price_promotions"].each_key { |k| available_promotions << k.to_i }
    available_promotions.sort.each { |x| correct_promotion = x if total_price > x}
    correct_promotion
  end

  def product_on_promotion(product_code)
    @promotions["product_promotions"].has_key?(product_code)
  end

  def product_fulfulls_promotion(product_code)
    required_amount = @promotions["product_promotions"][product_code]["quantity_required"]
    @order.count(product_code) >= required_amount
  end

end
