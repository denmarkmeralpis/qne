# frozen_string_literal: true

require_relative 'QNE/tax_code/all'
require_relative 'QNE/tax_code/output_tax_codes'
require_relative 'QNE/tax_code/input_tax_codes'

module QNE
  class TaxCodes < Base
    include ::QNE::QueryBuilder

    def all(params = {})
      @response = QNE::TaxCode::All.new(
        conn, params: uri_query(params)
      ).call

      parse_to_json(@response.body)
    end

    def output_tax_codes(params = {})
      @response = QNE::TaxCode::OutputTaxCodes.new(
        conn, params: uri_query(params)
      ).call

      parse_to_json(@response.body)
    end

    def input_tax_codes(params = {})
      @response = QNE::TaxCode::InputTaxCodes.new(
        conn, params: uri_query(params)
      ).call

      parse_to_json(@response.body)
    end
  end
end
