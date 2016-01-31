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

  it "over £60 promotion discount 10 percent off" do
    checkout.scan('001')
    checkout.scan('002')
    checkout.scan('003')
    expect(checkout.total).to eq (66.78)
  end

  it "two or more lavender hearts at £8.50 promotion" do
    checkout.scan('001')
    checkout.scan('003')
    checkout.scan('001')
    expect(checkout.total).to eq (36.95)
  end

  it "two or more lavender hearts at £8.50 promotion instead of £60 promotions" do
    checkout.scan('001')
    checkout.scan('002')
    checkout.scan('001')
    checkout.scan('003')
    expect(checkout.total).to eq (73.76)
  end

  it "discount when ordering over two 001 products" do
    checkout.scan('001')
    checkout.scan('001')
    expect(checkout.total).to eq (17.00)
  end

  it "checks if item is in the £60 promotion range" do
    checkout.scan('002')
    checkout.scan('002')
    expect(checkout.find_correct_total_price_promotion(61.00)).to eq(60)
  end

  it "checks if two 001 codes is in promotion" do
    checkout.scan('001')
    checkout.scan('001')
    expect(checkout.product_fulfulls_promotion("001")).to eq(true)
  end

end
