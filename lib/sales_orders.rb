# frozen_string_literal: true

require_relative 'QNE/sales_order/all'
require_relative 'QNE/sales_order/show'
require_relative 'QNE/sales_order/create'

module QNE
  class SalesOrders < Base
    include ::QNE::QueryBuilder

    def all(params = {})
      @response = QNE::SalesOrder::All.new(
        conn, params: uri_query(params)
      ).call

      parse_to_json(@response.body)
    end

    def show(id)
      @response = QNE::SalesOrder::Show.new(
        conn, id: id
      ).call

      parse_to_json(@response.body)
    end

    def create(request_body)
      @response = QNE::SalesOrder::Create.new(
        conn, request_body: request_body
      ).call

      parse_to_json(@response.body)
    end
  end
end
