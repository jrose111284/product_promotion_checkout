require "checkout"

describe Checkout do
  subject(:checkout) { described_class.new('./products.json', './promotions.json') }

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

  it "adds up prices" do
    checkout.scan('001')
    checkout.scan('002')
    expect(checkout.total).to eq (54.25)
  end

  it "applys over £60 promotion" do
    checkout.scan('001')
    checkout.scan('002')
    checkout.scan('003')
    expect(checkout.total).to eq (66.78)
  end

  it "applys over £60 promotion" do
    checkout.scan('002')
    checkout.scan('002')
    checkout.scan('003')
    expect(checkout.total).to eq (76.97)
  end

  it "applys discount when ordering over two 001 products" do
    checkout.scan('001')
    checkout.scan('001')
    expect(checkout.total).to eq (17.00)
  end

end
