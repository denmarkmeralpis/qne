require 'spec_helper'

module QNE
  RSpec.describe SalesOrders do
    let(:conn) { QNE::Connection.new(db_code: 'dbcode') }

    describe '#all' do
      before do
        mock = instance_double(QNE::SalesOrder::All)
        resp = double(body: '[{}]')

        allow(QNE::SalesOrder::All).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns Array of customers' do
        expect(conn.sales_orders.all(top: 5)).to be_a(Array)
      end
    end

    describe '#show' do
      before do
        mock = instance_double(QNE::SalesOrder::Show)
        resp = double(body: '{}')

        allow(QNE::SalesOrder::Show).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns a Hash' do
        expect(conn.sales_orders.show('uuid-uuid-uuid')).to be_a(Hash)
      end
    end

    describe '#create' do
      before do
        mock = instance_double(QNE::SalesOrder::Create)
        resp = double(body: { id: '123' }.to_json)

        allow(QNE::SalesOrder::Create).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns object hash' do
        expect(conn.sales_orders.create(somekey: :value_pair)).to be_a(Hash)
      end
    end
  end
end