require 'spec_helper'
require 'webmock/rspec'

module QNE
  module Customer
    RSpec.describe Update do
      describe '#call' do
        let(:conn) { QNE::Connection.new(db_code: 'dbcode') }
        let(:qne) { described_class.new(conn.connection, request_body: body) }
        let(:body) do
          {
            id: "1ac3227c-f5e0-4052-9f66-0ca8d9666ec8",
            address1: "Zone 2, San Antonio, MILAOR, CAMARINES SUR",
            address2: "San Antonio/MILAOR",
            address3: "CAMARINES SUR",
            attention: "John Doe",
            customer: "xxxxxxxxx",
            details: [
              {
                dateRef1: "2023-06-07T01:19:37.167Z",
                description: "PRODUCT X",
                numbering: "1",
                project: "PROJECT",
                qty: 5,
                stock: "495992",
                stockLocation: "AL",
                unitPrice: "17.5",
                uom: "piece"
              }
            ],
            doAddress1: "Zone 2, San Antonio, MILAOR, CAMARINES SUR",
            doAddress2: "San Antonio/MILAOR",
            doAddress3: "CAMARINES SUR",
            doContact: "John Doe",
            doPhone: "0999999999",
            invoiceDate: "2023-06-07T01:19:37.167Z",
            invoiceTo: "Doe Store",
            phone: "0999999999",
            project: "PROJECT",
            referenceNo: "R88888",
            remark1: "PM1",
            stockLocation: "LOCATION",
            title: "PICKER NAME",
            title2: "CHECKER NAME"
          }
        end

        before do
          stub_request(:put, conn.class::BASE_URI + qne.class::PATH).with(
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