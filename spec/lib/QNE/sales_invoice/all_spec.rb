require 'spec_helper'
require 'webmock/rspec'

module QNE
  module SalesInvoice
    RSpec.describe All do
      let(:conn) { QNE::Connection.new(db_code: 'dbcode') }
      let(:qne) { described_class.new(conn.connection, params: { '$top' => 10 }) }

      describe '#call' do
        before do
          stub_request(:get, conn.class::BASE_URI + qne.class::PATH).with(
            query: { '$top' => 10 },
            headers: { 'DbCode' => 'dbcode' }
          ).to_return(status: 200, body: [{ id: 1 }].to_json)
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