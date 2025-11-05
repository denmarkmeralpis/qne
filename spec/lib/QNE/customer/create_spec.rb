# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

module QNE
  module Customer
    RSpec.describe Create do
      describe '#call' do
        let(:conn) { QNE::Connection.new(db_code: 'dbcode') }
        let(:qne) { described_class.new(conn.connection, request_body: body) }
        let(:body) do
          {
            companyName: 'DEN - (ABELLA NAGA CITY)',
            companyName2: 'DEN IBARRA',
            controlAccount: '11301-000-0000',
            category: 'T2 SARI-SARI',
            address1: 'AL3 ABELLA NAGA CITY CAMARINES SUR',
            address2: 'ABELLA',
            address3: 'NAGA CITY/CAMARINES SUR',
            contactPerson: 'DEN IBARRA',
            email: '',
            phoneNo1: '09123456789',
            businessNature: 'SARI-SARI STORE',
            area: 'NAGA CITY',
            defaultTaxCode: 'SR-SP',
            status: 'ACTIVE'
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
