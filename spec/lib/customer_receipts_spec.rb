# frozen_string_literal: true

require 'spec_helper'

module QNE
  RSpec.describe CustomerReceipts do
    let(:conn) { QNE::Connection.new(db_code: 'dbcode') }

    describe '#create' do
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
        mock = instance_double(QNE::CustomerReceipt::Create)
        resp = double(body: { id: '123' }.to_json)

        allow(QNE::CustomerReceipt::Create).to receive(:new)
          .with(conn.connection, request_body: body).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns object hash' do
        expect(conn.customer_receipts.create(body)).to be_a(Hash)
      end
    end
  end
end
