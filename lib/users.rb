# frozen_string_literal: true

require_relative 'QNE/user/login'

module QNE
  class Users < Base
    def login(username:, password:, db_code:)
      @response = QNE::User::Login.new(
        @conn, params: {
          dbCode: db_code,
          userName: username,
          password: password
        }
      ).call

      parse_to_json(@response.body)
    end
  end
end
