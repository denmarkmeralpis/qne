# frozen_string_literal: true

require_relative 'QNE/stock_report/stock_location_balance'

module QNE
  class StockReports < Base
    include ::QNE::QueryBuilder

    def find_stocks_location_balance_by_date(as_of_date: Date.today)
      @response = QNE::StockReport::StockLocationBalance.new(
        conn, as_of_date
      ).call

      parse_to_json(@response.body)
    end
  end
end
