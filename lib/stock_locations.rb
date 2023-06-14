# frozen_string_literal: true

require_relative 'QNE/stock_location/all'

module QNE
  class StockLocations < Base
    include ::QNE::QueryBuilder

    def all(params = {})
      @response = QNE::StockLocation::All.new(
        conn, params: uri_query(params)
      ).call

      parse_to_json(@response.body)
    end
  end
end
