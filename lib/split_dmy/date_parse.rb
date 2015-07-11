module SplitDmy
  module DateParse

    def validate_date(field)
      date = Date.new(
          instance_variable_get("@#{field}_year"),
          instance_variable_get("@#{field}_month"),
          instance_variable_get("@#{field}_day")
      )
      self.send("#{field}=", date)
    rescue
      self.send("#{field}=", nil)
    end
  end
end
