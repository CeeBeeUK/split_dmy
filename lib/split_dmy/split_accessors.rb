module SplitDmy
  module SplitAccessors
    PARTS = %w[day month year].freeze

    def split_dmy_accessor(*attrs)
      require 'split_dmy/date_validator'

      attrs.each do |attr|
        override_builtin(attr)
        add_attr_accessors(attr)
        add_virtus_attributes(attr)
        extend_validation(attr)
      end
      add_methods
      override_permitted_attributes(attrs)
    end

    private

    def override_permitted_attributes(attrs)
      array = attrs.product(PARTS).map { |attr, part| "#{attr}_#{part}".to_sym }

      define_method(:permitted_attributes) do
        super().push(array)
      end
    end

    def extend_validation(attr)
      define_method("validate_#{attr}_partials") do
        dv = DateValidator.new(self, attr)
        if attr.present? && dv.any_errors?
          errors.delete(attr.to_sym)
          errors.add(attr.to_sym, :invalid)
        end
      end
    end

    def override_builtin(attr)
      after_initialize do
        full_date = send(attr.to_s)
        split_into_parts(attr, full_date) unless full_date.nil?
      end

      define_method("#{attr}=") do |val|
        super(val)
        split_into_parts(attr, Date.parse(val.to_s)) unless val.nil?
      end
    end

    def add_methods
      define_method('split_into_parts') do |attr, full_date|
        instance_variable_set("@#{attr}_day", full_date.day)
        instance_variable_set("@#{attr}_month", full_date.month)
        instance_variable_set("@#{attr}_year", full_date.year)
      end
    end

    def add_virtus_attributes(attr)
      PARTS.each do |part|
        attribute "#{attr}_#{part}", String
      end
    end

    def add_attr_accessors(attr)
      PARTS.each do |part|
        define_method("#{attr}_#{part}=") do |val|
          instance_variable_set("@#{attr}_#{part}", val)
          new = DateValidator.new(self, attr).partial_updated
          send("#{attr}=", new)
        end

        define_method("#{attr}_#{part}") do
          instance_variable_get("@#{attr}_#{part}")
        end
      end
    end
  end
end
