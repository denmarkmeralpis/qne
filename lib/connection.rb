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

module QNE
  class Connection
    BASE_URI = 'https://dev-api.qne.cloud'.freeze

    attr_reader :connection

    def initialize(db_code:)
      @db_code = db_code || ENV['QNE_DB_CODE']
      @faraday_params = { url: BASE_URI, headers: { 'DbCode' => @db_code } }
      @connection = Faraday.new(@faraday_params) do |config|
        config.adapter :net_http_persistent
      end
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

    def connected?
      authenticated?
    end

    def authenticated?
      conn = Faraday.new(@faraday_params) do |config|
        config.options.timeout = ENV.fetch('QNE_TEST_CONNECTION_TIMEOUT', 10)
      end

      qne = QNE::SystemVersion.new(conn)
      qne.call
      qne.success?
    end
  end
end
