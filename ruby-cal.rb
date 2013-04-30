# month = ARGV[0]
# year = ARGV[1]


class Cal
  attr_accessor :month
  attr_accessor :year

  @@month_array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  @@month_number_array = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
  @@days_array = %w[Su Mo Tu We Th Fr Sa]

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

  def month_to_s
    month = @month
    if month.class == Fixnum
      return @@month_array[@month - 1]
    end
    if month.class == String
      if @@month_array.include?(month)
        index = @@month_array.index(month)
        return @@month_array[index]
      elsif @@month_number_array.include?(month)
        index = @@month_number_array.index(month)
        return @@month_array[index]
      end
    else
        raise ArgumentError, "#{@month} is neither a month number (1..12) nor a name"
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


  def print_header
    month = month_to_s
    header = "#{month} #{@year}"
    header.center(20)
  end

  def print_weekdays
    @@days_array.join(" ")
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

  def format_week (week) #weeks are zero indexed
    # date_array = Array(1..30)
    # index_of_start = start_day_index
    # @@days_array[0...index_of_start].fill("  ").join(" ") + "  " + date_array[0...(7 - index_of_start)].join("  ")+"\n" + " " + date_array[(7 - index_of_start)...(13 - index_of_start)].join("  ")

    first_week_days = 7 - start_day_index
    formatted_week = ""
    if week == 0
      empty_days = 7 - first_week_days
      empty_days.times { formatted_week += "   " }
      first_date = 1
      last_date = first_week_days
    else
      first_date = first_week_days + 1 + ((week - 1) * 7)
      last_date = last_date + 6 > month_days ? month_days : last_date + 6
    end
    (first_date..last_date).each do | date |
      formatted_week += " " if date < 10
      formatted_week += "#{date}"
      formatted_week += " " unless date == last_date
    end
    formatted_week

  end


  # def print_cal
  #   puts full_header
  #   puts find_week
  # end

if __FILE__ == $0
  month = ARGV[0]
  year = ARGV[1]
  cal = Cal.new(month, year)
  puts cal.print_full_header
  cal.format_week
end

end

