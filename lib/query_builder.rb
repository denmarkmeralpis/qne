# frozen_string_literal: true

module QNE
  module QueryBuilder
    OPERATORS = {
      eq: {
        string: "COLUMN OPERATOR 'VALUE'",
        default: 'COLUMN OPERATOR VALUE'
      },
      in: {
        default: 'COLUMN OPERATOR (VALUE)'
      }
    }.freeze

    def eq_query(queries)
      filters = queries.map { |column, value| "#{column} eq '#{value}'" }
      filters.join(' and ')
    end

    def multi_query(queries)
      filters = queries.map do |column, operators|
        operators.map do |operator, value|
          parse_query_by_operator(column, operator, value)
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

    def parse_query_by_operator(col, operator, val)
      string = OPERATORS[operator.to_sym]
      datatype = val.class.name.downcase.to_sym

      return "#{col} #{operator} #{val}" unless string

      query = String.new(string[datatype] || string[:default])

      query.gsub!(/COLUMN/, col.to_s)
      query.gsub!(/OPERATOR/, operator.to_s)
      query.gsub!(/VALUE/, val)
    end

    def filterables
      @filterables ||= {}
    end
  end
end
