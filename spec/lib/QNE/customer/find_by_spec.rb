# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

module QNE
  module Customer
    RSpec.describe FindBy do
      let(:conn) { QNE::Connection.new(db_code: 'dbcode') }
      let(:customer) do
        described_class.new(
          conn.connection, params: "phoneNo1 eq '09123456789'"
        )
      end

      describe '#call' do
        before do
          stub_request(:get, conn.class::BASE_URI + customer.class::PATH).with(
            query: { '$filter' => "phoneNo1 eq '09123456789'" },
            headers: { 'DbCode' => 'dbcode' }
          ).and_return(status: 200, body: [{ id: 1 }].to_json)
        end

        it 'responds to :body' do
          expect(customer.call).to respond_to(:body)
        end
      end
    end
  end
end
