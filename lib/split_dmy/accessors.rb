require 'split_dmy/date_parse'

module SplitDmy
  module Accessors
    def split_dmy_accessor(*fields)
      include DateParse

      options = fields.extract_options!
      fields.each do |field|

        define_method("#{field}_or_new") do
          self.send(field) || options.fetch(:default, ->{ Date.new(0, 1, 1) }).call
        end

        add_methods(field, 'day')
        add_methods(field, 'month')
        add_methods(field, 'year')
      end
    end

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
