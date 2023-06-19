# frozen_string_literal: true

module QNE
  module Customer
    class Find
      PATH = '/api/Customers/:id'.freeze

      def initialize(conn, id:)
        @conn = conn
        @id = id
      end

      def call
        @conn.get(PATH.gsub(':id', @id))
      end
    end
  end
end
