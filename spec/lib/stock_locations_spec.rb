require 'spec_helper'

module QNE
  RSpec.describe Stocks do
    let(:conn) { QNE::Connection.new(db_code: 'dbcode') }

    describe '#all' do
      before do
        mock = instance_double(QNE::Stock::All)
        resp = OpenStruct.new(body: '[]')

        allow(QNE::Stock::All).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns an Array' do
        expect(conn.stocks.all).to be_a(Array)
      end
    end
  end
end