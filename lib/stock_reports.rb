# frozen_string_literal: true

require_relative 'QNE/stock_report/stock_location_balance'

module QNE
  class StockReports < Base
    include ::QNE::QueryBuilder

    def find_stocks_location_balance_by_date(as_of_date: Date.today, stock_location: nil)
      @response = QNE::StockReport::StockLocationBalance.new(
        conn, as_of_date
      ).call

      parsed = parse_to_json(response.body)

      # Handle API error response
      return parsed if parsed.is_a?(Hash)

      if stock_location.present?
        parsed.select { |stock| stock['locationCode'] == stock_location }
      else
        parsed
      end
    end
  end
end
