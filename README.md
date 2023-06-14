# QNE

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/QNE`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

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
   - [Customers](#customers)
   - [Customer Categories](#customer-categories)
   - [Sales Invoices](#sales-invoices)
   - [Sales Orders](#sales-orders)
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
    category: "T2 SARI-SARI",
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/QNE. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/QNE/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the QNE project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/QNE/blob/main/CODE_OF_CONDUCT.md).
