# month = ARGV[0]
# year = ARGV[1]


class Cal
  attr_accessor :month, :year 

  @@month_array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  @@month_number_array = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
  @@days_array = %w[Su Mo Tu We Th Fr Sa]
  @@months_with_30_days = %w[September April June Novemeber]
  @@months_with_31_days = %w[January March May July August September December]

  def initialize( month, year )
    if month.class == Fixnum
      raise ArgumentError, "#{month} is not a month number (1..12)" if month > 12
      raise ArgumentError, "#{month} is not a month number (1..12)" if month < 1
      @month = month
    elsif month.class == String
      if @@month_array.include?(month)
        index = @@month_array.index(month)
        @month = @@month_array[index]
      elsif @@month_number_array.include?(month)
        index = @@month_number_array.index(month)
        @month = @@month_array[index]
      else
      raise ArgumentError, "#{@month} is neither a month number (1..12) nor a name"
      end
    end
    @year = year
  end

  def month_name
    month = @month
    month_int = month.to_i
    if month_int > 0
      return @@month_array[month_int - 1]
    else 
      if @@month_array.include?(month)
        index = @@month_array.index(month)
        return @@month_array[index]
      else 
        raise ArgumentError, "#{@month} is neither a month number (1..12) nor a name"
      end
    end
  end

  def month_to_Fixnum
    month = @month
    if month.class == Fixnum
      return month
    end
    if month.class == String
      if @@month_array.include?(month)
        index = @@month_array.index(month)
        return @@month_array.index(month) + 1
      elsif @@month_number_array.include?(month)
        return @@month_number_array.index(month) + 1
      end
    else
        raise ArgumentError, "#{@month} is neither a month number (1..12) nor a name"
    end
  end

  def days_in_month
    current_month = month_name
    current_year = @year
    if @@months_with_30_days.include?(current_month)
      return 30;
    elsif @@months_with_31_days.include?(current_month)
      return 31
    elsif current_month === "February"
      if leap_year? 
        return 29
      else 
        return 28
      end
    end
  end

  def print_year_header
    current_year = @year
    current_year.center(64)
  end

  def print_header
    month = month_name
    header = "#{month} #{@year}"
    header.center(20)
  end

  def print_weekdays
    @@days_array.join(" ")
  end

  def print_3_month_header
    three_month_header = ""
    last_index = 2
    @@month_array[0..last_index].each {|month| month === @@month_array[last_index] ? three_month_header += month.center(20) : three_month_header += month.center(20) + "  "}
    three_month_header
  end

  def print_3_month_week_header
    week_header = ""
    3.times do |x| 
      x === 3 ? week_header += @@days_array.join(" ") : week_header += @@days_array.join(" ") + "  "
    end
    return week_header.chomp("  ")
  end

  def print_full_header
    month_header = print_header
    weekdays = print_weekdays
    full_header = "#{month_header}\n#{weekdays}"
  end

  def leap_year?
    year = @year.to_i
    if year%400 === 0
       true
    elsif year%100 === 0 
       false
    elsif year%4 === 0
       true
    else
       false
    end
  end

  def find_start_day
    m = month_to_Fixnum
    y = @year.to_i
    q = 1 #first day of month

    if m < 3
      m += 12
      y = y - 1
    end
    
    h = ((q + (((m + 1) *26 )/10) + y + (y/4) + (6 * (y/100)) + (y/400))%7)

    start_day = @@days_array[h - 1]
  end

  def start_day_index
    start = find_start_day
    index_of_start = @@days_array.index(start)
  end

  def format_week(week) #weeks are zero indexed
    index_of_start = start_day_index
    month_days = days_in_month
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
    formatted_week

  end

  def format_week_1_for_3_months(week) #weeks are zero indexed
    if week == 0
      formatted_week = ""
    @@month_array[0..2].each{|x| formatted_week += format_week_for_year(0, x) + "  "} 
    return formatted_week
    else
      return "not week one"
    end

  end

  def format_week_for_year(week, month) #weeks are zero indexed
    @month = month
    index_of_start = start_day_index
    month_days = days_in_month
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
    formatted_week
  end

  def format_month
    formatted_month = ""
    (0..5).each{|x| formatted_month += format_week(x) + "\n"}
    formatted_month 
  end

  def format_year(month, year)


  end

  def print_cal
    puts print_full_header
    puts format_month
  end

if __FILE__ == $0
  month = ARGV[0]
  year = ARGV[1]
  cal = Cal.new(month, year)
  cal.print_cal
end

end

