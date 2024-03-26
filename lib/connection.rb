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
    BASE_URI = 'https://dev-api.qne.cloud'.freeze

    attr_reader :api_token, :token_expiration

    def initialize(db_code:, username: nil, password: nil)
      @db_code = db_code || ENV['QNE_DB_CODE']
      @username = username
      @password = password
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
      conn = Faraday.new(@faraday_params) do |config|
        config.options.timeout = ENV.fetch('QNE_TEST_CONNECTION_TIMEOUT', 5)
      end

      QNE::SystemVersion.new(conn).call
    rescue Faraday::TimeoutError
      false
    end

    def authenticated?
      qne = QNE::SystemVersion.new(connection)
      qne.call
      qne.success?
    end

    private

    def connection
      @connection ||= Faraday.new(faraday_params) do |config|
        config.adapter :net_http_persistent
      end
    end

    def auth_method
      if @username.nil? || @password.nil?
        dbcode_auth
      else
        bearer_auth
      end
    end

    def faraday_params
      @faraday_params ||= auth_method
    end

    def dbcode_auth
      @dbcode_auth ||= {
        url: BASE_URI,
        headers: {
          'DbCode' => @db_code
        }
      }
    end

    def bearer_auth
      @bearer_auth ||= {
        url: BASE_URI,
        headers: {
          'Authorization' => "Bearer #{fetch_api_token}"
        }
      }
    end

    def fetch_api_token
      return @api_token if valid_token?

      reqs = users
      resp = reqs.login(
        db_code: @db_code,
        username: @username,
        password: @password
      )

      if reqs.success?
        @api_token = resp['token']
        @token_expiration = Date.parse(resp['expiration'])

        return @api_token
      else
        raise QNE::UnathorizedError
      end
    end

    def valid_token?
      api_token && token_expiration > Date.today
    end
  end
end
