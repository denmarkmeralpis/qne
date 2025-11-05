# frozen_string_literal: true

require 'json'

module QNE
  class Base
    attr_reader :response, :conn

    def initialize(conn)
      @conn = conn
    end

    def parse_to_json(respose_body)
      JSON.parse(respose_body)
    end

    def success?
      return false unless response

      response.success?
    end
  end
end
