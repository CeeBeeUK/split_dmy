module SplitDmy
  class DateValidator
    def initialize(object, attribute)
      @split_day = object.instance_variable_get("@#{attribute}_day")
      @split_month = object.instance_variable_get("@#{attribute}_month")
      @split_year = object.instance_variable_get("@#{attribute}_year").to_i
      @object = object
      @attr = attribute
    end

    def partial_updated
      new_date = build_date
      partials_valid? && new_date ? new_date : nil
    end

    def parse_month(val)
      if valid_fixnum?(val, 12) || valid_numeric_string?(val, 12)
        result = val.to_i
      else
        mon_name = valid_month_name?(val)
        result = mon_name.present? ? mon_name : val
      end
      result.to_i
    end

    def build_date
      date = Date.new(
        @split_year.to_i,
        parse_month(@split_month),
        @split_day.to_i
      )
      date if partials_match_date(date)
    rescue
      false
    end

    def any_errors?
      !partials_valid? || partials_valid_date_fails?
    end

    private

    def partials_valid?
      { d: valid_day?, m: valid_month?, y: valid_year? }.values.all?
    end

    def partials_valid_date_fails?
      partials_valid? && !build_date
    end

    def partials_match_date(date)
      date.day == @split_day.to_i &&
        date.month == parse_month(@split_month).to_i &&
        date.year == @split_year.to_i
    end

    def valid_day?
      (valid_fixnum?(@split_day, 31) || valid_numeric_string?(@split_day, 31))
    end

    def valid_month?
      (
        valid_fixnum?(@split_month, 12) ||
        valid_numeric_string?(@split_month, 12) ||
        valid_month_name?(@split_month)
      )
    end

    def valid_year?
      (
        valid_fixnum?(@split_year, 3333) ||
        valid_numeric_string_year?(@split_year)
      )
    end

    def valid_fixnum?(x, max)
      x.is_a?(Fixnum) && x > 0 && x <= max
    end

    def valid_numeric_string?(x, max)
      x =~ /^[0-9]{1,2}$/ && x.to_i <= max
    end

    def valid_numeric_string_year?(x)
      x =~ /^[0-9]{4}$/ && x.to_i <= 3333 && x.to_i > 0000
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
