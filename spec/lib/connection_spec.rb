require 'spec_helper'

module QNE
  RSpec.describe Connection do
    describe '#customers' do
      let(:conn) { described_class.new(db_code: 'QNEDBCODE') }

      it 'initializes QNE::Customers' do
        expect(conn.customers).to be_instance_of(QNE::Customers)
      end
    end
  end
end
