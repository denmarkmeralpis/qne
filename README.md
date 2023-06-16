# QNE

A ruby wrapper for QNE APIs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'QNE'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install QNE

## Usage

Authorize your request by initializing your `db_code`:

```ruby
conn = QNE::Connection.new(db_code: 'YouDbCodeHere')
```

then you can use it to perform desired operation

```ruby
conn.customers.all(top: 10) # returns top 10 customers
```

1. [Filters](#filters)
2. List of available APIs:
   - [Customers](#Customers)
   - [Customer Categories](#Customer-Cetegories)
   - [Default Tax Code](#Default-Tax-Code)
   - [Sales Invoices](#Sales-Invoice)
   - [Sales Orders](#Sales-Orders)
   - [Stocks](#stocks)
   - [Stock Locations](#stock-location)
   - [Terms](#terms)

### Filters

You can filter the dataset by using `.where` method.

| Name | Description           |
| ---- | --------------------- |
| `eq` | equal                 |
| `ne` | not equal             |
| `gt` | greater than          |
| `lt` | less than             |
| `ge` | greater than or equal |
| `le` | less than or equal    |

Example:

```ruby
conn.sales_orders.where(status: { eq: 'ACTIVE' })
```

You may also use other api queries such as:

| Name      | Description                                                                                                                                  |
| --------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `top`     | Returns the top `X` results of the query.                                                                                                    |
| `skip`    | Skips `X` results of the query.                                                                                                              |
| `orderby` | Allows you to define the ordering of the returned dataset.                                                                                   |
| `select`  | Allows you to define a subset of properties to return from that Resource. Performance wise, you should define the properties set explicitly. |

##### Example:

```ruby
conn.customers.where(id: { ne: 1 }).all(top: 10, skip: 0)
```

### Customers

**1. Fetch all customers**

```ruby
conn.customers.all
```

**2. Get a customer by attribute(s):**

```ruby
conn.customers.find_by(id: 'xxx-xxx-xxx', status: 'ACTIVE')
```

**3. Create a customer:**

```ruby
# hash
customer_hash = {
    companyName: "DEN - (ABELLA NAGA CITY)",
    companyName2: "DEN IBARRA",
    controlAccount: "xxx-xxx-xxx",
    category: "CATEGORY A",
    address1: "AL3 ABELLA NAGA CITY CAMARINES SUR",
    address2: "ABELLA",
    address3: "NAGA CITY/CAMARINES SUR",
    contactPerson: "DEN IBARRA",
    email: "",
    phoneNo1: "09123456789",
    businessNature: "Something",
    area: "NAGA CITY",
    defaultTaxCode: "Something",
    status: "ACTIVE"
}

# creates customer
conn.customers.create(customer_hash)
```

**4. View specific customer**

```ruby
conn.customers.show('id-of-the-customer')
```

**5. Update customer details**

```ruby
customer_hash = {
    id: "2e2041e9-e963-4ae6-86a5-b9e3c5b808ce",
    companyCode: "xxxx-xxxxx",
    companyName: "DEN - (ABELLA NAGA CITY)",
    companyName2: "DEN IBARRA"
}

conn.customers.update(customer_hash)
```

### Customer Categories

**1. Fetch all customer categories**

```ruby
conn.customer_categories.all
```

### Default Tax Code

```ruby
conn.default_tax_code
```

### Sales Invoices

**1. Fetch all sales invoices**

```ruby
conn.sales_invoices.all
```

**2. View a specific sales invoice:**

```ruby
conn.sales_invoices.show('xxx-xxx-xxx')
```

**3. Create a sales invoice:**

```ruby
sales_invoice_hash = {
  address1: "Zone 2, San Antonio, MILAOR, CAMARINES SUR",
  address2: "San Antonio/MILAOR",
  address3: "CAMARINES SUR",
  attention: "John Doe",
  customer: "xxxxxxxxxx",
  details: [
    {
      dateRef1: "2023-06-07T01:19:37.167Z",
      description: "Product X",
      numbering: "1",
      project: "PROJECT A",
      qty: 5,
      stock: "9999",
      stockLocation: "LOCATION_CODE",
      unitPrice: "17.5",
      uom: "piece"
    }
  ],
  doAddress1: "Zone 2, San Antonio, MILAOR, CAMARINES SUR",
  doAddress2: "San Antonio/MILAOR",
  doAddress3: "CAMARINES SUR",
  doContact: "John Doe",
  doPhone: "09999999999",
  invoiceDate: "2023-06-07T01:19:37.167Z",
  invoiceTo: "Doe Store",
  phone: "09999999999",
  project: "PROJECT A",
  referenceNo: "R9999-9-9",
  remark1: "PM1",
  stockLocation: "LOCATION CODE",
  title: "PICKER NAME",
  title2: "CHECKER NAME"
}

conn.sales_invoices.create(sales_invoice_hash)
```

**4. Update a sales invoice:**

```ruby
sales_invoice_hash = {
  id: "xxxxxxxxx",
  address1: "Updated address",
  address2: "Updated address2",
  address3: "CAMARINES SUR",
  attention: "John Doe",
  customer: "xxxxxxxxxx",
  details: [
    {
      dateRef1: "2023-06-07T01:19:37.167Z",
      description: "Product X",
      numbering: "1",
      project: "PROJECT A",
      qty: 5,
      stock: "9999",
      stockLocation: "LOCATION_CODE",
      unitPrice: "17.5",
      uom: "piece"
    }
  ],
  doAddress1: "Updated address",
  doAddress2: "San Antonio/MILAOR",
  doAddress3: "CAMARINES SUR",
  doContact: "John Doe",
  doPhone: "09999999999",
  invoiceDate: "2023-06-07T01:19:37.167Z",
  invoiceTo: "Doe Store",
  phone: "09999999999",
  project: "PROJECT A",
  referenceNo: "R9999-9-9",
  remark1: "PM1",
  stockLocation: "LOCATION CODE",
  title: "PICKER NAME",
  title2: "CHECKER NAME"
}

conn.sales_invoices.update(sales_invoice_hash)
```

**5. Generate sales invoice download link**

There are two types of downloadable links:
1. `tax_invoice`
2. `sales_invoice` (default)

```ruby
conn.sales_invoices.download('id-of-sales-invoice', 'tax_invoice')
```

### Sales Orders

**1. Fetch all sales orders**

```ruby
conn.sales_orders.all
```

**2. View a specific sales order:**

```ruby
conn.sales_orders.show('xxx-xxx-xxx')
```

**3. Create a sales order:**

```ruby
sales_order_hash = {
  address1: "Zone 9, San Antonio, MILAOR, CAMARINES SUR",
  address2: "San Antonio/MILAOR",
  address3: "CAMARINES SUR",
  attention: "John Doe",
  customer: "customer-id-123",
  customerName: "Doe Store",
  details: [
    {
      description: "Product Name",
      qty: "5",
      stock: "1495992",
      unitPrice: "17.5",
      uom: "piece"
    }
  ],
  doAddress1: "Zone 9, San Antonio, MILAOR, CAMARINES SUR",
  doAddress2: "San Antonio/MILAOR",
  doAddress3: "CAMARINES SUR",
  doContact: "John Doe",
  doPhone: "09999999999",
  isApproved: true,
  isCancelled: false,
  isTaxInclusive: true,
  orderDate: "2023-06-01T01:19:37.167Z",
  phone: "09999999999",
  referenceNo: "R99999-9-9",
  remark1: "",
  project: "PROJECT NAME",
  stockLocation: "STOCK CODE"
}

conn.sales_orders.create(sales_order_hash)
```

### Stocks

**1. Fetch all stocks**

```ruby
conn.stocks.all
```

**2. Fetch all UOMs of a specific stock**

```ruby
conn.stocks.find_by_id('stock-id')
```

### Stock Locations

**1. Fetch all stock locations**

```ruby
conn.stock_locations.all
```

_Note: `filters` and `queries` won't work for this specific action._

### Terms

**1. Fetch all terms**

```ruby
conn.terms.all
```

**2. Get a term by attribute(s):**

```ruby
conn.terms.show('id')
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/QNE. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/QNE/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the QNE project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/QNE/blob/main/CODE_OF_CONDUCT.md).
