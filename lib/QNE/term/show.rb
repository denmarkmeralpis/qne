# frozen_string_literal: true

module QNE
  module Term
    class Show
      PATH = '/api/Terms/:id'

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
