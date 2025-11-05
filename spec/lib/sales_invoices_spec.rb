require 'spec_helper'

module QNE
  RSpec.describe SalesOrders do
    let(:conn) { QNE::Connection.new(db_code: 'dbcode') }

    describe '#all' do
      before do
        mock = instance_double(QNE::SalesInvoice::All)
        resp = double(body: '[{}]')

        allow(QNE::SalesInvoice::All).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns Array of customers' do
        expect(conn.sales_invoices.all(top: 5)).to be_a(Array)
      end
    end

    describe '#show' do
      before do
        mock = instance_double(QNE::SalesInvoice::Show)
        resp = double(body: '{}')

        allow(QNE::SalesInvoice::Show).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns a Hash' do
        expect(conn.sales_invoices.show('uuid-uuid-uuid')).to be_a(Hash)
      end
    end

    describe '#create' do
      before do
        mock = instance_double(QNE::SalesInvoice::Create)
        resp = double(body: { id: '123' }.to_json)

        allow(QNE::SalesInvoice::Create).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns object hash' do
        expect(conn.sales_invoices.create(somekey: :value_pair)).to be_a(Hash)
      end
    end

    describe '#update' do
      before do
        mock = instance_double(QNE::SalesInvoice::Update)
        resp = double(body: { id: '123' }.to_json)

        allow(QNE::SalesInvoice::Update).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns object hash' do
        expect(conn.sales_invoices.update(somekey: :value_pair)).to be_a(Hash)
      end
    end
  end
end