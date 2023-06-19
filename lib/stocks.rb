# frozen_string_literal: true

require_relative 'QNE/stock/all'
require_relative 'QNE/stock/uoms'
require_relative 'QNE/stock/find'

module QNE
  class Stocks < Base
    include ::QNE::QueryBuilder

    attr_reader :id

    def find(id)
      finder = QNE::Stocks::Find.new(conn, id: id).call

      return unless finder.success?

      define_singleton_method 'uoms' do
        find_uoms_by_id(id)
      end

      define_singleton_method 'show' do
        @response = parse_to_json(finder.body)
      end

      self
    end

    def all(params = {})
      @response = QNE::Stock::All.new(
        conn, params: uri_query(params)
      ).call

      parse_to_json(@response.body)
    end

    def find_uoms_by_id(id)
      @response = QNE::Stock::UOMs.new(
        conn, id: id
      ).call

      parse_to_json(@response.body)
    end
  end
end
