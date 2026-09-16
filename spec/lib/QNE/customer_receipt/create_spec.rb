# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

module QNE
  module CustomerReceipt
    RSpec.describe Create do
      describe '#call' do
        let(:conn) { QNE::Connection.new(db_code: 'dbcode') }
        let(:qne) { described_class.new(conn.connection, request_body: body) }
        let(:body) do
          {
            customerCode: 'CUST-0001',
            docDate: '2023-06-07T01:19:37.167Z',
            amount: 1000.00,
            id: '2e2041e9-e963-4ae6-86a5-b9e3c5b808ce',
            depositAccountCode: '10101-000-0000',
            salesPersonCode: 'SP-0001',
            costCentreCode: 'CC-0001',
            projectCode: 'PROJECT A',
            currencyRate: 1.0,
            docCode: 'CR-000001',
            description: 'Payment for outstanding invoice',
            referenceNo: 'OR-000001',
            bankChargesAccountCode: '60101-000-0000',
            bankCharges: 0.00
          }
        end

        before do
          stub_request(:post, conn.class::BASE_URI + qne.class::PATH).with(
            body: body.to_json,
            headers: {
              'Content-Type' => 'application/json',
              'Dbcode' => 'dbcode'
            }
          ).to_return(status: 200, body: '{}')
        end

        it 'responds to :body' do
          expect(qne.call).to respond_to(:body)
        end

        it 'responds to :success?' do
          expect(qne.call).to respond_to(:success?)
        end
      end
    end
  end
end
