class Cal
  attr_accessor :month, :year 

  MONTHS = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  MONTH_NUMBER = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  MONTH_NUMBER_STRING = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
  DAYS_ARRAY = %w[Su Mo Tu We Th Fr Sa]
  MONTHS_WITH_30_DAYS = %w[September April June November]
  MONTHS_WITH_31_DAYS = %w[January March May July August September October December]
  YEAR_RANGE = (1800..3000)

  def initialize( month = nil, year = nil)
    if month && year
      month_number = month.to_i
      year_number = year.to_i
        
        if month_number == 0
          raise ArgumentError, "#{month} is neither a month number (1..12) nor a name" if !MONTHS.include?(month)
          @month = MONTHS.index(month) + 1
        else
          @month = month_number
          raise ArgumentError, "#{month} is neither a month number (1..12) nor a NAME" if !MONTH_NUMBER.include?(month_number)
        end
      @year = year_number
      raise ArgumentError, "#{year} is not in the year range of 1800..3000" if !YEAR_RANGE.include?(@year) 
    
    elsif month && year.nil?
      year_number = month.to_i
      @month = "all"
      @year = year_number
      if !YEAR_RANGE.include?(year_number) 
        raise ArgumentError, "#{month} is an invalid calendar entry."
      end

    else
      @month = Time.new.month
      @year = Time.new.year
    end
  end

  def month_name month
    MONTHS[month - 1]
  end

  def days_in_month (month, year)
    current_month = month_name(month)
    current_year = year
    days_in_month = ""
    if MONTHS_WITH_30_DAYS.include?(current_month)
      days_in_month = 30
    elsif MONTHS_WITH_31_DAYS.include?(current_month)
      days_in_month = 31
    elsif current_month === "February"
      if self.leap_year?
        days_in_month = 29
      else 
        days_in_month = 28
      end
    end
    days_in_month
  end

  def print_month_header month, year
    month = month_name(month)
    header = "#{month} #{year}"
    header.center(20).rstrip
  end

  def print_weekdays
    DAYS_ARRAY.join(" ")
  end

  def print_full_header month, year
    month_header = print_month_header(month, year)
    weekdays = print_weekdays
    full_header = "#{month_header}\n#{weekdays}"
  end

  def leap_year?
    if @year%400 === 0
      true
    elsif @year%100 === 0 
      false
    elsif @year%4 === 0
      true
    else
      false
    end
  end

  def find_start_day_index (month, year)
    #Zeller's Congruence(http://en.wikipedia.org/wiki/Zeller's_congruence) 
    m = month
    y = year
    q = 1
    if m < 3
      m += 12
      y = y - 1
    end
    h = ((q + (((m + 1) *26 )/10) + y + (y/4) + (6 * (y/100)) + (y/400))%7)
    start_day = DAYS_ARRAY[h - 1]
    index_of_start = DAYS_ARRAY.index(start_day)
  end

  def format_week(week, month, year)#weeks are zero indexed
    index_of_start = find_start_day_index(month, year)
    days_in_month = days_in_month(month, year)
    first_week_days = 7 - index_of_start 
    formatted_week = ""
    if week == 0 #if first_week? (week == 0)
      empty_days = 7 - first_week_days
      empty_days.times { formatted_week += "   " }
      first_date = 1
      last_date = first_week_days
    else
      first_date = first_week_days + 1 + ((week - 1) * 7)
      last_date = first_date + 6 > days_in_month ? days_in_month : first_date + 6
    end
    (first_date..last_date).each do | date |
      formatted_week += " " if date < 10
      formatted_week += "#{date}"
      formatted_week += " " unless date == last_date
    end
    #Add extra spacing if printing for a year
    if @month === "all"
      if formatted_week.length < 20
        extra_space = 20 - formatted_week.length
        extra_space.times {formatted_week += " "}
      end
    end  
    formatted_week
  end

  def format_month(month, year)
    formatted_month = ""
    formatted_month += print_full_header(month, year) + "\n"
    (0..5).each{|week| formatted_month += format_week(week, month, year) + "\n"}
    formatted_month 
  end

# YEAR VIEW

  def print_year_header year
    year = year.to_s
    year.center(63).rstrip
  end

  def print_3_month_header(month)
    month_start_index = month - 1
    three_month_header = ""
    last_index = month_start_index + 2
    MONTHS[month_start_index..last_index].each do |month|
      if month === MONTHS[last_index]
        three_month_header += month.center(20).rstrip
      else
        three_month_header += month.center(20) + "  "
      end
    end
    three_month_header
  end

  def print_3_month_week_header
    week_header = ""
    3.times do |x|
      x === 3 ? week_header += DAYS_ARRAY.join(" ") : week_header += DAYS_ARRAY.join(" ") + "  "
    end
    return week_header.chomp("  ")
  end

  def format_weeks_for_3_months(month_index, year) #weeks are zero indexed
    month_start = month_index.to_i
    month_end = month_start + 2
    formatted_week = ""
    week_number = 0
      while week_number < 6
        MONTHS[month_start..month_end].each do | month |
          if month === MONTHS[month_end]
            formatted_week += format_week(week_number, MONTHS.index(month) + 1, year).rstrip
          else
            formatted_week += format_week(week_number, MONTHS.index(month) + 1, year) + "  "
          end
        end
        formatted_week = "#{formatted_week}\n"
        week_number += 1
      end
    formatted_week.chomp("  ")
  end

  def format_year(month, year)
    month_index = 0
    month = 1
    output = ""
    output += print_year_header(year) + "\n\n"
    until month_index >= 12
      output += print_3_month_header(month) + "\n"
      output += print_3_month_week_header + "\n"
      output += format_weeks_for_3_months(month_index, year)
    month_index += 3
    month += 3
    end
    output
  end

  def print_cal
    if month === "all"
    puts format_year(month, year)
    else 
    puts format_month(month, year)
    end
  end

end

if __FILE__ == $0
  month = ARGV[0]
  year = ARGV[1]
  cal = Cal.new(month, year)
  cal.print_cal
end