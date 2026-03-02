# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

module QNE
  module StockReport
    RSpec.describe StockLocationBalance do
      let(:conn) { QNE::Connection.new(db_code: 'dbcode') }
      let(:qne) { described_class.new(conn.connection, Date.today) }

      describe '#call' do
        before do
          params = "?asOfDate=#{Date.today.strftime('%Y-%m-%d')}"
          path = qne.class::PATH + params

          stub_request(:get, conn.class::BASE_URI + path).with(
            headers: { 'DbCode' => 'dbcode' }
          ).to_return(status: 200, body: {
            stockCode: 'sku1',
            availableQty: 2
          }.to_json)
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
