# frozen_string_literal: true

require 'spec_helper'

module QNE
  RSpec.describe Stocks do
    let(:conn) { QNE::Connection.new(db_code: 'dbcode') }

    describe '#find_uoms_by_id' do
      before do
        mock = instance_double(QNE::Stock::UOMs)
        resp = double(body: '{}')

        allow(QNE::Stock::UOMs).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns a Hash' do
        expect(conn.stocks.find_uoms_by_id('uuid-uuid-uuid')).to be_a(Hash)
      end
    end

    describe '#all' do
      before do
        mock = instance_double(QNE::Stock::All)
        resp = double(body: '[]')

        allow(QNE::Stock::All).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns an Array' do
        expect(conn.stocks.all).to be_a(Array)
      end
    end

    describe '#find_stocks_available_by_stock_code' do
      before do
        mock = instance_double(QNE::Stock::Available)
        resp = double(body: '{}')

        allow(QNE::Stock::Available).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns a Hash' do
        expect(conn.stocks.find_stocks_available_by_stock_code('sku1')).to be_a(Hash)
      end
    end
  end
end
