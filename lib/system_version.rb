# frozen_string_literal: true

module QNE
  class SystemVersion < Base
    PATH = '/api/System/Version'.freeze

    def call
      @response = conn.get(PATH)

      parse_to_json(@response.body)
    end
  end
end