require 'split_dmy/date_parse'

module SplitDmy
  module Accessors
    # rubocop:disable Metrics/MethodLength, NonLocalExitFromIterator
    def split_dmy_accessor(*fields)
      include DateParse

      fields.each do |field|
        define_method("#{field}=") do |date|
          return unless date.present?
          date = Date.parse(date.to_s) unless date.is_a?(Date)
          send("populate_partials", field, date)
          instance_variable_set("@#{field}", date)
        end

        add_methods(field, 'day')
        add_methods(field, 'month')
        add_methods(field, 'year')
      end
    end
    # rubocop:enable Metrics/MethodLength, NonLocalExitFromIterator

    def add_methods(field, attr)
      add_writer(field, attr)
      add_reader(field, attr)
    end

    def add_writer(field, attr)
      # Writer
      define_method("#{field}_#{attr}=") do |val|
        return unless val.present?
        send("valid_#{attr}?", "@#{field}_#{attr}", val)
        validate_date(field)
      end
    end

    def add_reader(field, attr)
      # Reader
      define_method("#{field}_#{attr}") do
        val = instance_variable_get("@#{field}_#{attr}")
        val = send(field).try "#{attr}".to_sym unless val.present?
        val
      end
    end
  end
end
