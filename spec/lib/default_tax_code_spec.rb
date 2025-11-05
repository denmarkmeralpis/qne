# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

module QNE
  RSpec.describe DefaultTaxCode do
    let(:conn) { QNE::Connection.new(db_code: 'dbcode') }
    let(:qne) { described_class.new(conn.connection) }

    describe '#call' do
      before do
        stub_request(:get, "#{conn.class::BASE_URI}#{qne.class::PATH}").with(
          headers: { 'DbCode' => 'dbcode' }
        ).to_return(status: 200, body: { taxCode: 'SR-SP' }.to_json)
      end

      it 'returns a Hash' do
        expect(qne.call).to be_a(Hash)
      end
    end
  end
end
