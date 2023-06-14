# frozen_string_literal: true

module QNE
  module StockLocation
    class All
      PATH = '/api/StockLocation'.freeze

      def initialize(conn)
        @conn = conn
      end

      def call
        @conn.get(PATH)
      end
    end
  end
end
