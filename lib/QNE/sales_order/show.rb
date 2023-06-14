# frozen_string_literal: true

module QNE
  module SalesOrder
    class Show
      PATH = '/api/SalesOrders/:id'.freeze

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