Time::DATE_FORMATS[:yymmdd]   = "%y%m%d"
Time::DATE_FORMATS[:american] = "%m/%d/%Y %l:%M %p"
Time::DATE_FORMATS[:default]  = "%m/%d/%Y %l:%M %p"

Date::DATE_FORMATS[:month_year] = "%m/%Y"
Date::DATE_FORMATS[:american] = "%m/%d/%Y"
Date::DATE_FORMATS[:default]  = "%m/%d/%Y"

class Date
  def self.with_standard_default(&block)
    orig = Date::DATE_FORMATS[:default]
    Date::DATE_FORMATS[:default] = nil
    result = yield block
    Date::DATE_FORMATS[:default] = orig
    result
  end
end
