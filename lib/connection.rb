# frozen_string_literal: true

require_relative 'agents'
require_relative 'customers'
require_relative 'customer_categories'
require_relative 'default_tax_code'
require_relative 'sales_invoices'
require_relative 'sales_orders'
require_relative 'stocks'
require_relative 'stock_locations'
require_relative 'system_version'
require_relative 'terms'
require_relative 'uoms'
require_relative 'tax_codes'
require_relative 'users'

module QNE
  class Connection
    BASE_URI = 'https://dev-api.qne.cloud'

    def initialize(options = {})
      @db_code = options.fetch(:db_code, nil) || ENV['QNE_DB_CODE']
      @api_token = options.fetch(:api_token, nil)
    end

    def system_version
      @system_version ||= QNE::SystemVersion.new(connection).call
    end

    def agents
      @agents ||= QNE::Agents.new(connection)
    end

    def customers
      @customers ||= QNE::Customers.new(connection)
    end

    def customer_categories
      @customer_categories ||= QNE::CustomerCategories.new(connection)
    end

    def default_tax_code
      @default_tax_code ||= QNE::DefaultTaxCode.new(connection).call
    end

    def sales_invoices
      @sales_invoices ||= QNE::SalesInvoices.new(connection)
    end

    def sales_orders
      @sales_orders ||= QNE::SalesOrders.new(connection)
    end

    def stocks
      @stocks ||= QNE::Stocks.new(connection)
    end

    def terms
      @terms ||= QNE::Terms.new(connection)
    end

    def stock_locations
      @stock_locations ||= QNE::StockLocations.new(connection)
    end

    def uoms
      @uoms ||= QNE::UOMs.new(connection)
    end

    def tax_codes
      @tax_codes ||= QNE::TaxCodes.new(connection)
    end

    def users
      @users ||= QNE::Users.new(Faraday.new(url: BASE_URI))
    end

    def connected?
      QNE::SystemVersion.new(connection).call
    rescue Faraday::TimeoutError
      false
    end

    def authenticated?
      qne = QNE::SystemVersion.new(connection)
      qne.call
      qne.success?
    end

    def connection
      @connection ||= Faraday.new(faraday_params)
    end

    private

    def faraday_params
      @faraday_params ||= {
        url: BASE_URI,
        headers: auth_method,
        request: request_options
      }
    end

    def auth_method
      @api_token ? bearer_auth : dbcode_auth
    end

    def dbcode_auth
      { 'DbCode' => @db_code }
    end

    def bearer_auth
      { 'Authorization' => "Bearer #{@api_token}" }
    end

    def request_options
      {
        read_timeout: ENV.fetch('FARADAY_READ_TIMEOUT', '60').to_i,
        timeout: ENV.fetch('FARADAY_TIMEOUT', '60').to_i
      }
    end
  end
end
