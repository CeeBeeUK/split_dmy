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

    def valid_day?(iv, d)
      valid = valid_fixnum?(d, 31) || valid_numeric_string?(d, 31)
      instance_variable_set(iv, d.to_i) if valid
    end

    def valid_month?(iv, month)
      if valid_fixnum?(month, 12) || valid_numeric_string?(month, 12)
        instance_variable_set(iv, month)
      else
        valid = valid_month_name?(month)
        instance_variable_set(iv, valid.to_i) if valid
      end
    end

    def valid_year?(iv, year)
      valid = valid_fixnum?(year, 3333) || valid_numeric_string_year?(year)
      instance_variable_set(iv, year.to_i) if valid
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
