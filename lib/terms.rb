# frozen_string_literal: true

require_relative 'QNE/term/all'
require_relative 'QNE/term/show'

module QNE
  class Terms < Base
    include ::QNE::QueryBuilder

    def all(params = {})
      @response = QNE::Term::All.new(
        conn, params: uri_query(params)
      ).call

      parse_to_json(@response.body)
    end

    def show(id)
      @response = QNE::Term::Show.new(
        conn, id: id
      ).call

      parse_to_json(@response.body)
    end
  end
end
