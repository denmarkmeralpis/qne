# frozen_string_literal: true

module QNE
  module QueryBuilder
    def eq_query(queries)
      filters = queries.map { |column, value| "#{column} eq '#{value}'" }
      filters.join(' and ')
    end

    def multi_query(queries)
      filters = queries.map do |column, operators|
        operators.map do |operator, value|
          value = value.is_a?(String) ? "'#{value}'" : value
          "#{column} #{operator} #{value}"
        end
      end

      filters.join(' and ')
    end

    def uri_query(queries)
      return filterables if queries.empty?

      filters = queries.map do |filter, value|
        { "$#{filter}" => value }
      end

      filterables.merge(filters.reduce(&:merge))
    end

    def where(params)
      filterables['$filter'] = multi_query(params)

      self
    end

    private

    def filterables
      @filterables ||= {}
    end
  end
end
