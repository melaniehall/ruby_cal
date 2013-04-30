# month = ARGV[0]
# year = ARGV[1]

class Cal
  attr_accessor :month
  attr_accessor :year

  def initialize( month, year )
    @month = month
    @year = year
  end

  def month_to_s
    month = @month
    month_array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    month_number_array = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    if month.class == Fixnum
      raise ArgumentError, "#{month} is not a month number (1..12)" if month > 12
      raise ArgumentError, "#{month} is not a month number (1..12)" if month < 1
      return month_array[@month - 1]
    elsif month.class == String
      if month_array.include?(month)
        index = month_array.index(month)
        return month_array[index]
      elsif month_number_array.include?(month)
        index = month_number_array.index(month)
        return month_array[index]
      else 
        raise ArgumentError, "#{@month} is neither a month number (1..12) nor a name"
      end
    else
      raise ArgumentError, "#{@month} is neither a month number (1..12) nor a name"
    end
  end

  def print_header
    month = month_to_s
    header = "#{month} #{@year}"
    header.center(20)
  end

  def print_weekdays
    weekdaysArray = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    weekdays = weekdaysArray.join(" ")
  end

  def print_full_header
    month_header = print_header
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

  def find_start_day
    m = @month
    y = @year
    q = 1 #first day of month

    if m === 1
      m = 13
      y = y-1
    elsif m === 2
      m = 14
      y = y-1
    end
    
    h = ((q + (((m + 1) *26 )/10) + y + (y/4) + (6 * (y/100)) + (y/400))%7)


    weekdaysArray2 = ["Sa", "Su", "Mo", "Tu", "We", "Th", "Fr"]

    start_day = weekdaysArray2[h]

  end

  def find_week
    weekdaysArray = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    monthArray = Array(1..30)
    start = find_start_day
    weekdaysArray.index(start)
    weekdaysArray[0...1].fill("  ").join(" ") + "  " + monthArray[0...6].join("  ")

  end

  # def print_cal
  #   puts full_header
  #   puts find_week
  # end

if __FILE__ == $0
  cmd_month = ARGV[0]
  cmd_year = ARGV[1]
  cal = Cal.new(cmd_month, cmd_year)
  puts cal.print_full_header
  puts cal.find_week
end

end

