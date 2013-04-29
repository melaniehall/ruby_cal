require 'test/unit'
require './ruby-cal.rb'

class CalTest < Test::Unit::TestCase

  def test_01_initialize_stores_month
    calendar = Cal.new(5, 2013)
    assert_equal(5, calendar.month)
  end

  def test_02_initialize_stores_year
    calendar = Cal.new(5, 2013)
    assert_equal(2013, calendar.year)
  end

  # def test_03_error_with_bad_arguments
  #   calendar = Cal.new(15, 2021)
  #   assert_raise ArgumentError do
  #   end
  # end

  def test_03_print_month
    calendar = Cal.new(5, 2013)
    month = calendar.month_to_s
    assert_equal("May", month)
  end 

  def test_04a_print_header
    calendar = Cal.new(1, 2013)
    header = calendar.print_header
    assert_equal("    January 2013    ", header)
  end

  def test_04b_print_header
    calendar = Cal.new(2, 2013)
    header = calendar.print_header
    assert_equal("   February 2013    ", header)
  end

  def test_05_print_header
    calendar = Cal.new(3, 2013)
    header = calendar.print_header
    assert_equal("     March 2013     ", header)
  end

  def test_06_print_weekdays
    calendar = Cal.new(3, 2013)
    assert_equal("Su Mo Tu We Th Fr Sa", calendar.print_weekdays)
  end

  def test_07_print_full_header
    calendar = Cal.new(3, 2013)
    assert_equal("     March 2013     \nSu Mo Tu We Th Fr Sa", calendar.print_full_header)
  end

  def test_08_test_if_leap_year
    calendar1 = Cal.new(3, 2000)
    calendar2 = Cal.new(3, 2012)
    calendar3 = Cal.new(3, 1800)
    calendar4 = Cal.new(3, 2013)
    assert_equal(true, calendar1.leap_year?)
    assert_equal(true, calendar2.leap_year?)
    assert_equal(false, calendar3.leap_year?)
    assert_equal(false, calendar4.leap_year?)
  end

end

