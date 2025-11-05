# frozen_string_literal: true

module QNE
  module SalesInvoice
    class FindBy
      PATH = '/api/SalesInvoices'

      def initialize(conn, params:)
        @conn = conn
        @params = params
      end

      def call
        @conn.get(PATH) do |req|
          req.params['$filter'] = @params
        end
      end
    end
  end
end
