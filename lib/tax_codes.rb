# frozen_string_literal: true

require_relative 'QNE/tax_code/all'

module QNE
  class TaxCodes < Base
    include ::QNE::QueryBuilder

    def all(params = {})
      @response = QNE::TaxCode::All.new(
        conn, params: uri_query(params)
      ).call

      parse_to_json(@response.body)
    end
  end
end
