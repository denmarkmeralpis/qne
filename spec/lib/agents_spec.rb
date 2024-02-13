require 'spec_helper'

module QNE
  RSpec.describe Agents do
    let(:conn) { QNE::Connection.new(db_code: 'dbcode') }

    describe '#all' do
      before do
        mock = instance_double(QNE::Agent::All)
        resp = OpenStruct.new(body: '[{}]')

        allow(QNE::Agent::All).to receive(:new).and_return(mock)
        allow(mock).to receive(:call).and_return(resp)
      end

      it 'returns Array of customers' do
        expect(conn.agents.all(top: 5)).to be_a(Array)
      end
    end
  end
end