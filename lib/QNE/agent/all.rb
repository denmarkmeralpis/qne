# frozen_string_literal: true

module QNE
  module Agent
    class All
      PATH = '/api/Agents'

      def initialize(conn, params: {})
        @conn = conn
        @params = params
      end

      def call
        @conn.get(PATH) do |req|
          @params.each do |key, val|
            req.params[key] = val
          end
        end
      end
    end
  end
end