module SplitDmy
  module Accessors
    def split_dmy_accessor(*fields)

      fields.each do |field|
        add_methods(field, 'day')
        add_methods(field, 'month')
        add_methods(field, 'year')
      end
    end

    def add_methods(field, attr)
      # Writer
      define_method("#{field}_#{attr}=") do |val|
        instance_variable_set("@#{field}_#{attr}", val)
      end

      # Reader
      define_method("#{field}_#{attr}") do
        instance_variable_get("@#{field}_#{attr}")
      end
    end
  end
end
