# frozen_string_literal: true

require_relative 'QNE/customer_receipt/create'

module QNE
  class CustomerReceipts < Base
    include ::QNE::QueryBuilder

    def create(request_body)
      @response = QNE::CustomerReceipt::Create.new(
        conn, request_body: request_body
      ).call

      parse_to_json(@response.body)
    end
  end
end
