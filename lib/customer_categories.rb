# frozen_string_literal: true

require_relative 'QNE/customer_category/all'

module QNE
  class CustomerCategories < Base
    include ::QNE::QueryBuilder

    def all(params = {})
      @response = QNE::CustomerCategory::All.new(
        conn, params: uri_query(params)
      ).call

      parse_to_json(@response.body)
    end
  end
end
