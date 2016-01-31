# Product Promotion checkout
### Instructions
please follow these commands in terminal
```
git clone git@github.com:jrose111284/product_promotion_checkout.git
bundle
irb
require './lib/checkout'
co = Checkout.new('./products.json', './promotions.json')
co.scan("001")
co.scan("003")
co.scan("001")
co.total
=> 36.95
```

### My Approach
After reading the task the thing that stood out the most was "because our promotions will change, it needs to be flexible regarding our promotional rules." It seemed to me it needed some sort or data source like a JSON file.
So i used 2 JSON files one for products, and one for promotions.
As it needed to be flexible so any discount could change, it needed to work with this program. Here is example of my JSON file
```
"total_price_promotions": {
  "60": {
    "discount_percentage": 0.1
  },
  "100": {
    "discount_percentage": 0.3
  }
},
"product_promotions": {
  "001": {
    "quantity_required": 2,
    "discount_price": 8.50
  }
}
}
```

Here i have a product promotion, and a total discount promotion. As long as you keep it in this format, you will be able to change any promotion you wish in the future. I added a over £100 promotion with 30 percent off, just because it needed to be flexible, and could find the best deal for the customer. This added feature was only to show the flexibility it required. I felt the only way this would work is to make sure nothing is hard coded, and did my best to stick to them rules
