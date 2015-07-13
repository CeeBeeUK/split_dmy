module SplitDmy
  module DateParse
    def validate_date(field)
      date = Date.new(
        instance_variable_get("@#{field}_year"),
        instance_variable_get("@#{field}_month"),
        instance_variable_get("@#{field}_day")
      )
      send("#{field}=", date)
    rescue
      send("#{field}=", nil)
    end

    def set_instance_variable(iv, value)
      instance_variable_set(iv, value.to_i)
    end

    def populate_partials(field, date)
      valid_day?("@#{field}_day", date.day)
      valid_month?("@#{field}_month", date.month)
      valid_year?("@#{field}_year", date.year)
    end

    def valid_day?(iv, day)
      valid = valid_fixnum?(day, 31) || valid_numeric_string?(day, 31)
      set_instance_variable(iv, day) if valid
    end

    def valid_month?(iv, month)
      if valid_fixnum?(month, 12) || valid_numeric_string?(month, 12)
        set_instance_variable(iv, month.to_i)
      else
        valid = valid_month_name?(month)
        set_instance_variable(iv, valid.to_i) if valid
      end
    end

    def valid_year?(iv, year)
      valid = valid_fixnum?(year, 3333) || valid_numeric_string_year?(year)
      set_instance_variable(iv, year.to_i) if valid
    end

    def valid_fixnum?(x, max)
      x.is_a?(Fixnum) && x > 0 && x <= max
    end

    def valid_numeric_string?(x, max)
      x =~ /^[0-9]{1,2}$/ && x.to_i <= max
    end

    def valid_numeric_string_year?(x)
      x =~ /^[0-9]{4}$/ && x.to_i <= 3333
    end

    def valid_month_name?(month)
      short_months = I18n.t('date.abbr_month_names')
      full_months  = I18n.t('date.month_names')
      if short_months.include?(month.to_s.capitalize)
        short_months.index(month.capitalize)
      elsif full_months.include?(month.to_s.capitalize)
        full_months.index(month.capitalize)
      end
    end
  end
end
