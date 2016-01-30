require "checkout"

describe Checkout do
  subject(:checkout) { described_class.new('./products.json') }

  it "can scan a barcode" do
    checkout.scan("001")
    expect(checkout.total).to eq(9.25)
  end

  it "won't accept an invalid product code" do
    expect { checkout.scan("banana") }.to raise_error "cant find this product"
  end

  it "barcode must be a string" do
    expect { checkout.scan(001) }.to raise_error "please enter string value"
  end


  xit "under £60, applying no promotions" do
    checkout.scan('001')
    checkout.scan('002')
    expect(checkout.total).to eq (54.25)
  end

end
