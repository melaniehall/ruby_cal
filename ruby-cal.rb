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
      month_int = month.to_i
      year_int = year.to_i
        if month_int == 0
          if MONTHS.include?(month)
            @month = MONTHS.index(month) + 1
            # index = MONTHS.index(month)
            # @month = MONTHS[index]
          else
            raise ArgumentError, "#{month} is neither a month number (1..12) nor a name"
          end
          
        else 
          raise ArgumentError, "#{month} is neither a month number (1..12) nor a NAME" if !MONTH_NUMBER.include?(month_int)
          @month = month_int
        end
      @year = year_int

    elsif month && year.nil?
      month_int = month.to_i
      @month = "all"
      @year = month.to_i

      if !YEAR_RANGE.include?(month_int) 
        raise ArgumentError, "#{month} is an invalid calendar entry."
      end

    else 
      @month = 5 #current month
      @year = 2013 #current year
    end
  end

  def month_name month
    if month > 0
      return MONTHS[month - 1]
    else 
      if MONTHS.include?(month)
        index = MONTHS.index(month)
        return MONTHS[index]
      else 
        raise ArgumentError, "#{month} is neither a month number (1..12) nor a name"
      end
    end
  end

  def days_in_month (month, year)
    current_month = month_name(month)
    current_year = year
    if MONTHS_WITH_30_DAYS.include?(current_month)
      return 30
    elsif MONTHS_WITH_31_DAYS.include?(current_month)
      return 31
    elsif current_month === "February"
      if self.leap_year?
        return 29
      else 
        return 28
      end
    end
  end

  def print_year_header year
    year = year.to_s
    year.center(64)
  end

  def print_header month, year
    month = month_name(month)
    header = "#{month} #{year}"
    header.center(20)
  end

  def print_weekdays
    DAYS_ARRAY.join(" ")
  end

  def print_3_month_header(month)
    month_start = month - 1
    three_month_header = ""
    last_index = month_start + 2
    MONTHS[month_start..last_index].each {|month| month === MONTHS[last_index] ? three_month_header += month.center(20) : three_month_header += month.center(20) + "  "}
    three_month_header
  end

  def print_3_month_week_header
    week_header = ""
    3.times do |x| 
      x === 3 ? week_header += DAYS_ARRAY.join(" ") : week_header += DAYS_ARRAY.join(" ") + "  "
    end
    return week_header.chomp("  ")
  end

  def print_full_header month, year
    month_header = print_header(month, year)
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

  def find_start_day (month, year)
    m = month
    y = year
    q = 1 #first day of month

    if m < 3
      m += 12
      y = y - 1
    end
    
    h = ((q + (((m + 1) *26 )/10) + y + (y/4) + (6 * (y/100)) + (y/400))%7)

    start_day = DAYS_ARRAY[h - 1]
  end

  def start_day_index(month, year)
    start = find_start_day(month, year)
    index_of_start = DAYS_ARRAY.index(start)
  end

  def format_week(week, month, year) #weeks are zero indexed
    index_of_start = start_day_index(month, year)
    month_days = days_in_month(month, year)
    first_week_days = 7 - index_of_start 
    formatted_week = ""
    if week == 0 #if first_week? (week == 0)
      empty_days = 7 - first_week_days
      empty_days.times { formatted_week += "   " }
      first_date = 1
      last_date = first_week_days
    else
      first_date = first_week_days + 1 + ((week - 1) * 7)
      last_date = first_date + 6 > month_days ? month_days : first_date + 6

    end
    (first_date..last_date).each do | date |
      formatted_week += " " if date < 10
      formatted_week += "#{date}"
      formatted_week += " " unless date == last_date
    end
    if formatted_week.length < 20
      extra_space = 20 - formatted_week.length
      extra_space.times {formatted_week += " "}
    end  
    formatted_week

  end

  def format_weeks_for_3_months(month_index, year) #weeks are zero indexed
    month_start = month_index.to_i
    month_end = month_start + 2
    formatted_week = ""
    week_num = 0
      while week_num < 6 
        MONTHS[month_start..month_end].each{| month | formatted_week += format_week(week_num, MONTHS.index(month) + 1, year) + "  "} 
        formatted_week = formatted_week.chomp("  ")
        formatted_week = "#{formatted_week}\n"
        week_num += 1
      end
    
      return formatted_week.chomp("  ")

  end

  def format_month(month, year)
    formatted_month = ""
    formatted_month += print_full_header(month, year) + "\n"
    (0..5).each{|week| formatted_month += format_week(week, month, year) + "\n"}
    formatted_month 
  end

  def format_year(month, year)
    week = 0
    month = 1
    output = ""
    output += print_year_header(year) + "\n\n"
    until week >= 12
      output += print_3_month_header(month) + "\n"
      output += print_3_month_week_header + "\n"
      output += format_weeks_for_3_months(week, year)
    week += 3
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

if __FILE__ == $0
  month = ARGV[0]
  year = ARGV[1]
  cal = Cal.new(month, year)
  cal.print_cal
end

end
