require 'spec_helper'
require 'byebug'

module QNE
  RSpec.describe Terms do
    let(:conn) { QNE::Connection.new(db_code: 'dbcode') }

    describe '#all' do
      before do
        mock = instance_double(QNE::Term::All)
        resp = OpenStruct.new(body: '[]')

        allow(QNE::Term::All).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns Array of terms' do
        expect(conn.terms.all(top: 5)).to be_a(Array)
      end
    end

    describe '#show' do
      before do
        mock = instance_double(QNE::Term::Show)
        resp = OpenStruct.new(body: '{}')

        allow(QNE::Term::Show).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns a Hash' do
        expect(conn.terms.show('uuid-uuid-uuid')).to be_a(Hash)
      end
    end
  end
end