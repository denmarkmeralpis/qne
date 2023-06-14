# frozen_string_literal: true

require_relative 'QNE/customer/all'
require_relative 'QNE/customer/create'
require_relative 'QNE/customer/find_by'
require_relative 'QNE/customer/show'
require_relative 'QNE/customer/update'

module QNE
  class Customers < Base
    include ::QNE::QueryBuilder

    def all(params = {})
      @response = QNE::Customer::All.new(
        conn, params: uri_query(params)
      ).call

      parse_to_json(@response.body)
    end

    def find_by(params)
      @response = QNE::Customer::FindBy.new(
        conn, params: eq_query(params)
      ).call

      body = parse_to_json(@response.body)

      @response.success? ? body.first : body
    end

    def create(request_body)
      @response = QNE::Customer::Create.new(
        conn, request_body: request_body
      ).call

      parse_to_json(@response.body)
    end

    def show(id)
      @response = QNE::Customer::Show.new(
        conn, id: id
      ).call

      parse_to_json(@response.body)
    end

    def update(request_body)
      @response = QNE::Customer::Update.new(
        conn, request_body: request_body
      ).call

      parse_to_json(@response.body)
    end
  end
end
