# frozen_string_literal: true

module QNE
  module User
    class Login
      PATH = '/api/Users/Login'.freeze

      def initialize(conn, params: {})
        @conn = conn
        @params = params
      end

      def call
        @conn.post(PATH) do |req|
          req.headers['Content-Type'] = 'application/json'
          req.body = @params.to_json
        end
      end
    end
  end
end
