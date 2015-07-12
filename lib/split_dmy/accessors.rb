require 'split_dmy/date_parse'

module SplitDmy
  module Accessors
    # rubocop:disable Metrics/MethodLength, AbcSize, NonLocalExitFromIterator
    def split_dmy_accessor(*fields)
      include DateParse

      fields.each do |field|
        define_method("#{field}=") do |date|
          return unless date.present?
          date = Date.parse(date.to_s) unless date.is_a?(Date)
          send("valid_day?", "@#{field}_day", date.day)
          send("valid_month?", "@#{field}_month", date.month)
          send("valid_year?", "@#{field}_year", date.year)
          instance_variable_set("@#{field}", date)
        end

        add_methods(field, 'day')
        add_methods(field, 'month')
        add_methods(field, 'year')
      end
    end
    # rubocop:enable Metrics/MethodLength, AbcSize

    def add_methods(field, attr)
      # Writer
      define_method("#{field}_#{attr}=") do |val|
        return unless val.present?
        send("valid_#{attr}?", "@#{field}_#{attr}", val)
        validate_date(field)
      end

      # Reader
      define_method("#{field}_#{attr}") do
        instance_variable_get("@#{field}_#{attr}")
      end
    end
  end
end
