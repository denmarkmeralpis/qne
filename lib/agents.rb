# frozen_string_literal: true

require_relative 'QNE/agent/all'

module QNE
  class Agents < Base
    include ::QNE::QueryBuilder

    def all(params = {})
      @response = QNE::Agent::All.new(
        conn, params: uri_query(params)
      ).call

      parse_to_json(@response.body)
    end
  end
end
