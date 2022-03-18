# Store cart task

## Getting Started

### Softwares requiered
- Docker

### Installing
```bash
$ docker build -t store-task .
```

### Run on sample products data
```bash
$ docker run --rm store-task /bin/bash -c "ruby bin/process.rb 'AAA'"
```

### Run tests
```bash
$ docker run --rm store-task /bin/bash -c "bundle exec rspec spec/"
```

## Assumptions
- Multiple promotions cannot be applied to the same product
- Product in the follow format:
```json
[
  {
    "code":"B",
    "price_cents":1000,
    "promotion":{
      "type":"combination",
      "product_code":"E",
      "price_cents":0
    }
  },
  {
    "code":"C",
    "price_cents":125,
    "promotion":{
      "type":"group",
      "quantity":6,
      "price_cents":600
    }
  }
]
```
- All keys for a product should be present in the product data, else the code will throw an exception.
- Current output price will be in USD.

## To use a new sample data
Please look at `bin/process.rb` file, you can change the `sample_products.json` file to use a new sample data.

## TODO
- Add support for multiple promotions
- Add CI
- Add support for other currencies
- Add better exception handling on invalid data
