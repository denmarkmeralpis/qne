# frozen_string_literal: true

module QNE
  module SalesInvoice
    class Download
      DOWNLOAD_TYPES = {
        sales_invoice: {
          path: '/api/Reports/SalesInvoices/:id/url'
        },
        tax_invoice: {
          path: '/api/Reports/Invoices/:id/url'
        }
      }.freeze

      def initialize(conn, id:, type:)
        @conn = conn
        @id = id
        @type = type.to_s.to_sym
      end

      def call
        @conn.get(DOWNLOAD_TYPES[@type][:path].gsub(':id', @id))
      end
    end
  end
end