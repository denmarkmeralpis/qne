# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

module QNE
  module SalesInvoice
    RSpec.describe Create do
      describe '#call' do
        let(:conn) { QNE::Connection.new(db_code: 'dbcode') }
        let(:qne) { described_class.new(conn.connection, request_body: body) }
        let(:body) do
          {
            address1: 'Zone 2, San Antonio, MILAOR, CAMARINES SUR',
            address2: 'San Antonio/MILAOR',
            address3: 'CAMARINES SUR',
            attention: 'John Doe',
            customer: 'xxxxxxxxxx',
            details: [
              {
                dateRef1: '2023-06-07T01:19:37.167Z',
                description: 'Product X',
                numbering: '1',
                project: 'PROJECT A',
                qty: 5,
                stock: '9999',
                stockLocation: 'LOCATION_CODE',
                unitPrice: '17.5',
                uom: 'piece'
              }
            ],
            doAddress1: 'Zone 2, San Antonio, MILAOR, CAMARINES SUR',
            doAddress2: 'San Antonio/MILAOR',
            doAddress3: 'CAMARINES SUR',
            doContact: 'John Doe',
            doPhone: '09999999999',
            invoiceDate: '2023-06-07T01:19:37.167Z',
            invoiceTo: 'Doe Store',
            phone: '09999999999',
            project: 'PROJECT A',
            referenceNo: 'R9999-9-9',
            remark1: 'PM1',
            stockLocation: 'LOCATION CODE',
            title: 'PICKER NAME',
            title2: 'CHECKER NAME'
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
