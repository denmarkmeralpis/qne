# frozen_string_literal: true

# require 'faraday'
require 'faraday/retry'
require 'faraday/net_http_persistent'
require_relative 'QNE/version'
require_relative 'query_builder'
require_relative 'base'
require_relative 'connection'

module QNE
  class Error < StandardError; end
  class UnathorizedError < Error; end
end
