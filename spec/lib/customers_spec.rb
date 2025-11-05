require 'spec_helper'

module QNE
  RSpec.describe Customers do
    let(:conn) { QNE::Connection.new(db_code: 'dbcode') }

    describe '#all' do
      before do
        mock = instance_double(QNE::Customer::All)
        resp = double(body: '[]')

        allow(QNE::Customer::All).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns Array of customers' do
        expect(conn.customers.all(top: 5)).to be_a(Array)
      end
    end

    describe '#find_by' do
      context 'with data' do
        before do
          mock = instance_double(QNE::Customer::FindBy)
          resp = double(body: [{ id: '123' }].to_json, success?: true)

          allow(QNE::Customer::FindBy).to receive(:new).and_return(mock)
          allow(mock).to receive(:call).and_return(resp)
        end

        it 'returns object Hash' do
          expect(conn.customers.find_by(phoneNo1: '09127239736')).to be_a(Hash)
        end
      end

      context 'without data' do
        before do
          mock = instance_double(QNE::Customer::FindBy)
          resp = double(body: '[]', success?: true)

          allow(QNE::Customer::FindBy).to receive(:new).and_return(mock)
          allow(mock).to receive(:call).and_return(resp)
        end

        it 'returns nil' do
          expect(conn.customers.find_by(phoneNo1: 'xxxxxxxx')).to be_nil
        end
      end
    end

    describe '#create' do
      before do
        mock = instance_double(QNE::Customer::Create)
        resp = double(body: { id: '123' }.to_json)

        allow(QNE::Customer::Create).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns object hash' do
        expect(conn.customers.create(somekey: :value_pair)).to be_a(Hash)
      end
    end

    describe '#show' do
      before do
        mock = instance_double(QNE::Customer::Show)
        resp = double(body: '{}')

        allow(QNE::Customer::Show).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns a Hash' do
        expect(conn.customers.show('uuid-uuid-uuid')).to be_a(Hash)
      end
    end

    describe '#update' do
      before do
        mock = instance_double(QNE::Customer::Update)
        resp = double(body: '{}')

        allow(QNE::Customer::Update).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns a Hash' do
        request_body = { id: 'xxx-xxx', companyName: 'nnn', companyCode: 'xxx' }
        expect(conn.customers.update(request_body)).to be_a(Hash)
      end
    end
  end
end