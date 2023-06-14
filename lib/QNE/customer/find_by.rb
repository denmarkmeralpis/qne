# frozen_string_literal: true

module QNE
  module Customer
    class FindBy
      PATH = '/api/Customers'.freeze

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