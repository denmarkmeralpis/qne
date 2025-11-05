# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

module QNE
  module SalesInvoice
    RSpec.describe Download do
      let(:conn) { QNE::Connection.new(db_code: 'dbcode') }

      describe '#call' do
        context 'when type is sales_invoice' do
          let(:type) { :sales_invoice }
          let(:qne) do
            described_class.new(
              conn.connection,
              id: 'uuid-uuid-uuid',
              type: type
            )
          end

          before do
            path = qne.class::DOWNLOAD_TYPES[type][:path]
            path = path.gsub(':id', 'uuid-uuid-uuid')

            stub_request(:get, conn.class::BASE_URI + path).with(
              headers: { 'DbCode' => 'dbcode' }
            ).to_return(
              status: 200,
              body: { file: 'https://blah.to/a.pdf' }.to_json
            )
          end

          it 'responds to :body' do
            expect(qne.call).to respond_to(:body)
          end

          it 'responds to :success?' do
            expect(qne.call).to respond_to(:success?)
          end
        end

        context 'when type is tax_invoice' do
          let(:type) { :tax_invoice }
          let(:qne) do
            described_class.new(
              conn.connection,
              id: 'uuid-uuid-uuid',
              type: type
            )
          end

          before do
            path = qne.class::DOWNLOAD_TYPES[type][:path]
            path = path.gsub(':id', 'uuid-uuid-uuid')

            stub_request(:get, conn.class::BASE_URI + path).with(
              headers: { 'DbCode' => 'dbcode' }
            ).to_return(
              status: 200,
              body: { file: 'https://blah.to/a.pdf' }.to_json
            )
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
end
