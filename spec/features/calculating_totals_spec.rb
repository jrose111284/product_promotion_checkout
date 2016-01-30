require "spec_helper"
require "checkout"

feature "calculates total price" do
  scenario "under £60, applying no promotions" do
    checkout = Checkout.new('./products.json')
    checkout.scan('001')
    checkout.scan('002')
    expect(checkout.total).to eq (54.25)
  end
end
