require "checkout"

describe Checkout do
  subject(:checkout) { described_class.new('./products.json') }

  it "can scan a barcode" do
    checkout.scan("001")
    expect(checkout.total).to eq(9.25)
  end

  xit "under £60, applying no promotions" do
    checkout.scan('001')
    checkout.scan('002')
    expect(checkout.total).to eq (54.25)
  end

end
