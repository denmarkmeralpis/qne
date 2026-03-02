# frozen_string_literal: true

module QNE
  module StockReport
    class StockLocationBalance
      PATH = '/api/StockReports/StockLocationBalance'

      def initialize(conn, as_of_date)
        @conn = conn
        @as_of_date = as_of_date.strftime('%Y-%m-%d')
      end

      def call
        params = "?asOfDate=#{@as_of_date}"
        @conn.get(PATH + params)
      end
    end
  end
end
