month = ARGV[0]
year = ARGV[1]

class Cal
  attr_accessor :month
  attr_accessor :year

  def initialize( month, year )
    @month = month
    @year = year
  end

end
