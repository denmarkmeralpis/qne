# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

module QNE
  module SalesInvoice
    RSpec.describe FindBy do
      let(:conn) { QNE::Connection.new(db_code: 'dbcode') }
      let(:sales_invoice) do
        described_class.new(
          conn.connection, params: "referenceNo eq 'R2100-1-999'"
        )
      end

      describe '#call' do
        before do
          stub_request(:get, conn.class::BASE_URI + sales_invoice.class::PATH).with(
            query: { '$filter' => "referenceNo eq 'R2100-1-999'" },
            headers: { 'DbCode' => 'dbcode' }
          ).and_return(status: 200, body: [{ id: 1 }].to_json)
        end

        it 'responds to :body' do
          expect(sales_invoice.call).to respond_to(:body)
        end
      end
    end
  end
end
