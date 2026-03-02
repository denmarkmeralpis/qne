# frozen_string_literal: true

require 'spec_helper'

module QNE
  RSpec.describe StockReports do
    let(:conn) { QNE::Connection.new(db_code: 'dbcode') }

    describe '#find_stocks_location_balance_by_date' do
      before do
        mock = instance_double(QNE::StockReport::StockLocationBalance)
        resp = double(body: '{}')

        allow(QNE::StockReport::StockLocationBalance).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns a Hash' do
        expect(conn.stock_reports.find_stocks_location_balance_by_date(as_of_date: Date.today)).to be_a(Hash)
      end
    end
  end
end
