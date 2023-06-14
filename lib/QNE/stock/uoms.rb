# frozen_string_literal: true

module QNE
  module Stock
    class UOMs
      PATH = '/api/Stocks/:id/UOMS'.freeze

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
