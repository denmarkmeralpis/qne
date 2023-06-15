# frozen_string_literal: true

require_relative 'QNE/stock_location/all'

module QNE
  class StockLocations < Base
    include ::QNE::QueryBuilder

    def all
      @response = QNE::StockLocation::All.new(conn).call

      parse_to_json(@response.body)
    end
  end
end
