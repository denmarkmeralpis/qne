# frozen_string_literal: true

require 'spec_helper'

module QNE
  RSpec.describe CustomerCategories do
    let(:conn) { QNE::Connection.new(db_code: 'dbcode') }

    describe '#all' do
      before do
        mock = instance_double(QNE::CustomerCategory::All)
        resp = double(body: '[{}]')

        allow(QNE::CustomerCategory::All).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns Array of customers' do
        expect(conn.customer_categories.all(top: 5)).to be_a(Array)
      end
    end
  end
end
