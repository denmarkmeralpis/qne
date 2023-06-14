# frozen_string_literal: true

require_relative 'QNE/stock/all'
require_relative 'QNE/stock/uoms'

module QNE
  class Stocks < Base
    include ::QNE::QueryBuilder

    attr_reader :id

    def all(params = {})
      @response = QNE::Stock::All.new(
        conn, params: uri_query(params)
      ).call

      parse_to_json(@response.body)
    end

    def find_uoms_by_id(id)
      @response = QNE::Stock::UOMs.new(
        conn, id: id
      ).call

      parse_to_json(@response.body)
    end
  end
end
