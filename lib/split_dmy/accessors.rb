module SplitDmy
  module Accessors
    def split_dmy_accessor(*fields)

      fields.each do |field|

        # Writers
        define_method("#{field}_day=") do |val|
          instance_variable_set("@#{field}_day", val)
        end

        define_method("#{field}_month=") do |val|
          instance_variable_set("@#{field}_month", val)
        end

        define_method("#{field}_year=") do |val|
          instance_variable_set("@#{field}_year", val)
        end

        # Readers
        define_method("#{field}_day") do
          instance_variable_get("@#{field}_day")
        end

        define_method("#{field}_month") do
          instance_variable_get("@#{field}_month")
        end

        define_method("#{field}_year") do
          instance_variable_get("@#{field}_year")
        end
      end
    end
  end
end
