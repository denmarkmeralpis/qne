# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

module QNE
  module SalesInvoice
    RSpec.describe Show do
      let(:conn) { QNE::Connection.new(db_code: 'dbcode') }
      let(:qne) { described_class.new(conn.connection, id: 'uuid-uuid-uuid') }

      describe '#call' do
        before do
          path = qne.class::PATH.gsub(':id', 'uuid-uuid-uuid')

          stub_request(:get, conn.class::BASE_URI + path).with(
            headers: { 'DbCode' => 'dbcode' }
          ).to_return(status: 200, body: { id: 'uuid-uuid-uuid' }.to_json)
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
