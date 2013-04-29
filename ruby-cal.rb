month = ARGV[0]
year = ARGV[1]

class Cal
  attr_accessor :month
  attr_accessor :year

  def initialize( month, year )
    @month = month
    @year = year
  end

  def month_to_s
    if @month === 1
      @month = "January"
    elsif @month === 2
      @month = "February"
    elsif @month === 3
      @month = "March"
    elsif @month === 4
      @month = "April"
    elsif @month === 5
      @month = "May"
    elsif @month === 6
      @month = "June"
    elsif @month === 7
      @month = "July"
    elsif @month === 8
      @month = "August"
    elsif @month === 9
      @month = "September"
    elsif @month === 10
      @month = "October"
    elsif @month === 11
      @month = "November"
    elsif @month === 12
      @month = "December"
    end
    return @month
  end

  def print_header
    month = month_to_s
    header = "#{@month} #{@year}"
    spaces = ""
    extra_space = ""
    unless header.length%2 === 0
      extra_space += " "
    end
    spacing = ((20 - header.length)/ 2)
    spacing.times do
      spaces += " "
    end
    header_centered = "#{spaces}#{header}#{spaces}#{extra_space}"
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

end
