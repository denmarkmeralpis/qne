# frozen_string_literal: true

require_relative 'QNE/sales_invoice/all'
require_relative 'QNE/sales_invoice/show'
require_relative 'QNE/sales_invoice/create'
require_relative 'QNE/sales_invoice/update'
require_relative 'QNE/sales_invoice/download'

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

    def update(request_body)
      @response = QNE::SalesInvoice::Update.new(
        conn, request_body: request_body
      ).call

      parse_to_json(@response.body)
    end

    def download(id, type = :sales_invoice)
      @response = QNE::SalesInvoice::Download.new(
        conn, id: id, type: type
      ).call

      parse_to_json(@response.body)
    end
  end
end
