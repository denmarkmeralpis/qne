# frozen_string_literal: true

require 'spec_helper'

module QNE
  RSpec.describe Connection do
    describe '#customers' do
      context 'when no errors occur' do
        let(:conn) { described_class.new(db_code: 'QNEDBCODE') }

        it 'initializes QNE::Customers' do
          expect(conn.customers).to be_instance_of(QNE::Customers)
        end
      end

      context 'when faraday got a problem' do
        let(:retry_block) { spy('retry_block') }
        let(:retry_options) do
          {
            max: 3, # Number of retries
            interval: 0.1, # Time between retries
            exceptions: [Faraday::TimeoutError],
            retry_block: retry_block
          }
        end

        let(:faraday_params) { { url: 'http://example.com' } }

        it 'retries the specified number of times on failure' do
          # Create a mock Faraday connection
          connection = Faraday.new(faraday_params) do |conn|
            conn.request :retry, retry_options
            conn.adapter :test do |stub|
              # Simulate failures for the first two attempts
              stub.get('/') { raise Faraday::TimeoutError }
              # Simulate success on the third attempt
              stub.get('/') { [200, {}, 'Success'] }
            end
          end

          # Perform the request
          response = connection.get('/')

          # Verify the response
          expect(response.status).to eq(200)
          expect(response.body).to eq('Success')
        end

        it 'raises an error if all retries fail' do
          # Create a mock Faraday connection
          connection = Faraday.new(faraday_params) do |conn|
            conn.request :retry, retry_options
            conn.adapter :test do |stub|
              # Simulate failures for all attempts
              stub.get('/') { raise Faraday::TimeoutError }
            end
          end

          # Perform the request and expect an exception
          expect { connection.get('/') }.to raise_error(Faraday::TimeoutError)
        end

        it 'executes the retry block on each retry' do
          # Create a Faraday connection with the retry middleware
          connection = Faraday.new(faraday_params) do |conn|
            conn.request :retry, retry_options
            conn.adapter :test do |stub|
              # Simulate failures for all attempts
              stub.get('/') { raise Faraday::TimeoutError }
            end
          end

          # Perform the request and expect it to fail
          expect { connection.get('/') }.to raise_error(Faraday::TimeoutError)

          # Verify that the retry block was called the expected number of times
          expect(retry_block).to have_received(:call).exactly(3).times
        end
      end
    end
  end
end
