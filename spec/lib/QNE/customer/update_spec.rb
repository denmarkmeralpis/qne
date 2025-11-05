# frozen_string_literal: true

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
            id: '2e2041e9-e963-4ae6-86a5-b9e3c5b808ce',
            companyCode: '11301-R0001075',
            companyName: 'RONIE3 - (CAROLINA NAGA CITY)',
            companyName2: 'RONIE3 AMATERASU'
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
