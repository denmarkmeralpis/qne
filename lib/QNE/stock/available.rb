# frozen_string_literal: true

module QNE
  module Stock
    class Available
      PATH = '/api/Stocks/available'

      def initialize(conn, stock_code:)
        @conn = conn
        @stock_code = stock_code
      end

      def call
        params = "?code=#{@stock_code}"
        @conn.get(PATH + params)
      end
    end
  end
end
