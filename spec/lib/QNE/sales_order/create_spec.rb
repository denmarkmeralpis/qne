# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

module QNE
  module SalesOrder
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
            customer: '11301-A0001287',
            customerName: 'John sari-sari store - (San Antonio - MILAOR)',
            details: [
              {
                description: 'ACTIVEX DUO WHITE FRESH BLUE ANTI GERM 60GX162',
                qty: '5',
                stock: '495992',
                unitPrice: '17.5',
                uom: 'piece'
              }
            ],
            doAddress1: 'Zone 2, San Antonio, MILAOR, CAMARINES SUR',
            doAddress2: 'San Antonio/MILAOR',
            doAddress3: 'CAMARINES SUR',
            doContact: 'John Doe',
            doPhone: '099999999',
            isApproved: true,
            isCancelled: false,
            isTaxInclusive: true,
            orderDate: '2023-06-01T01:19:37.167Z',
            phone: '099999999',
            referenceNo: 'R34131-1-5',
            remark1: '',
            project: 'NAGA ADMIN',
            stockLocation: 'AL'
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
