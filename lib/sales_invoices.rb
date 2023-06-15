# frozen_string_literal: true

require_relative 'QNE/sales_invoice/all'
require_relative 'QNE/sales_invoice/show'
require_relative 'QNE/sales_invoice/create'

module QNE
  class SalesInvoices < Base
    include ::QNE::QueryBuilder

    def all(params = {})
      @response = QNE::SalesInvoice::All.new(
        conn, params: uri_query(params)
      ).call

      parse_to_json(@response.body)
    end

    def show(id)
      @response = QNE::SalesInvoice::Show.new(
        conn, id: id
      ).call

      parse_to_json(@response.body)
    end

    def create(request_body)
      @response = QNE::SalesInvoice::Create.new(
        conn, request_body: request_body
      ).call

      parse_to_json(@response.body)
    end
  end
end
