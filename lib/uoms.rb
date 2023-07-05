# frozen_string_literal: true

require_relative 'QNE/uom/all'

module QNE
  class UOMs < Base
    include ::QNE::QueryBuilder

    def all(params = {})
      @response = QNE::UOM::All.new(
        conn, params: uri_query(params)
      ).call

      parse_to_json(@response.body)
    end
  end
end
