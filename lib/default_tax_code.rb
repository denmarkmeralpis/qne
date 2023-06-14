# frozen_string_literal: true

module QNE
  class DefaultTaxCode < Base
    include ::QNE::QueryBuilder

    PATH = '/api/DefaultTaxCodes/OutputTaxCode'.freeze

    def call
      @response = conn.get(PATH)

      parse_to_json(@response.body)
    end
  end
end