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

  def test_03a_invalid_argument_throws_error
    assert_raise ArgumentError do
    calendar = Cal.new(0, 2021)
    end
  end 

  def test_03b_invalid_argument_throws_error
    assert_raise ArgumentError do
    calendar = Cal.new("Janruary", 2021)
    end
  end 

  def test_04a_print_month_from_fixnum
    calendar = Cal.new(5, 2013)
    month = calendar.month_to_s
    assert_equal("May", month)
  end 

  def test_04b_print_month_from_string
    calendar = Cal.new("January", 2013)
    month = calendar.month_to_s
    assert_equal("January", month)
  end 

  def test_05a_print_header
    calendar = Cal.new(1, 2013)
    header = calendar.print_header
    assert_equal("    January 2013    ", header)
  end

  def test_05b_print_header
    calendar = Cal.new(2, 2013)
    header = calendar.print_header
    assert_equal("   February 2013    ", header)
  end

  def test_05c_print_header
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

  def test_09a_find_start_day
    calendar = Cal.new(4, 2013)
    assert_equal("Mo", calendar.find_start_day)
  end

  def test_09b_test_find_start_day
    calendar = Cal.new(3, 2000)
    assert_equal("We", calendar.find_start_day)
  end

  def test_09c_test_find_start_day
    calendar = Cal.new(1, 2000)
    assert_equal("Sa", calendar.find_start_day)
  end

  def test_10_format_week
    calendar = Cal.new(4, 2013)
    assert_equal("    1  2  3  4  5  6", calendar.format_week)
  end

  def test_11a_month_to_Fixnum
    calendar = Cal.new(4, 2013)
    assert_equal(4, calendar.month_to_Fixnum)
  end

  def test_11b_month_to_Fixnum
    calendar = Cal.new("May", 2013)
    assert_equal(5, calendar.month_to_Fixnum)
  end

  def test_11c_month_to_Fixnum
    calendar = Cal.new("5", 2013)
    assert_equal(5, calendar.month_to_Fixnum)
  end

  def test_12_format_week
    calendar = Cal.new(5, 2013)
    assert_equal( example, calendar.format_week)
  end
end

