# frozen_string_literal: true

module QNE
  module SalesInvoice
    class Show
      PATH = '/api/SalesInvoices/:id'

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
