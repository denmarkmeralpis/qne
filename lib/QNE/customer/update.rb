# frozen_string_literal: true

module QNE
  module Customer
    class Update
      PATH = '/api/Customers'

      def initialize(conn, request_body:)
        @conn = conn
        @request_body = request_body
      end

      def call
        @conn.put(PATH) do |req|
          req.headers['Content-Type'] = 'application/json'
          req.body = @request_body.to_json
        end
      end
    end
  end
end
