require 'test/unit'
require './ruby-cal.rb'

class CalTest < Test::Unit::TestCase

  def test_01a_initialize_stores_month
    calendar = Cal.new(5, 2013)
    assert_equal(5, calendar.month)
  end

  def test_01b_initialize_stores_month
    calendar = Cal.new("January", "2013")
    assert_equal(1, calendar.month)
  end

  def test_01c_initialize_stores_month
    calendar = Cal.new("1", "2013")
    assert_equal(1, calendar.month)
  end

  def test_02_initialize_stores_year
    calendar = Cal.new(5, 2013)
    assert_equal(2013, calendar.year)
  end

  def test_03a_invalid_month_number_throws_error
    assert_raise ArgumentError do
    calendar = Cal.new(0, 2021)
    end
  end 

  def test_03b_initialize_stores_year_only
    calendar = Cal.new(2021)
    assert_equal(2021, calendar.year)
    assert_equal("all", calendar.month)
  end 

  def test_04a_stores_default_month
    calendar = Cal.new()
    assert_equal(5, calendar.month)
  end 

  def test_04b_stores_default_month
    calendar = Cal.new()
    assert_equal(2013, calendar.year)
  end 


  def test_04b_month_name
    calendar = Cal.new("January", 2013)
    assert_equal("January", calendar.month_name(1))
  end 

  def test_04c_month_name
    calendar = Cal.new("1", "2013")
    assert_equal("February", calendar.month_name(2))
  end 

  def test_05a_print_header
    calendar = Cal.new(1, 2013)
    assert_equal("    January 2013    ", calendar.print_header(1, 2013))
  end

  def test_05b_print_header
    calendar = Cal.new(2, 2013)
    assert_equal("   February 2013    ", calendar.print_header(2, 2013))
  end

  def test_06_print_weekdays
    calendar = Cal.new(3, 2013)
    assert_equal("Su Mo Tu We Th Fr Sa", calendar.print_weekdays)
  end

  def test_07_print_full_header
    calendar = Cal.new(3, 2013)
    assert_equal("     March 2013     \nSu Mo Tu We Th Fr Sa", calendar.print_full_header(3, 2013))
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
    assert_equal("Mo", calendar.find_start_day(4, 2013))
  end

  def test_09b_find_start_day
    calendar = Cal.new(3, 2000)
    assert_equal("We", calendar.find_start_day(3, 2000))
  end

  def test_09c_test_find_start_day
    calendar = Cal.new(1, 2000)
    assert_equal("Sa", calendar.find_start_day(1, 2000))
  end

  def test_10_find_start_day_index
    calendar = Cal.new(1, 2000)
    assert_equal(6, calendar.start_day_index(1, 2000))
  end 

  def test_15a_days_in_month_for_30_day_month
    calendar = Cal.new(4, 2013)
    assert_equal(30, calendar.days_in_month(4, 2013))
  end

  def test_15b_days_in_month_for_31_day_month
    calendar = Cal.new(5, 2013)
    assert_equal(31, calendar.days_in_month(5, 2013))
  end

  def test_15c_days_in_month_for_february_leap_year
    calendar = Cal.new("2", 2012)
    assert_equal(29, calendar.days_in_month(2, 2012))
  end

  def test_15d_days_in_month_for_february_common_year
    calendar = Cal.new("2", 2013)
    assert_equal(28, calendar.days_in_month(2, 2013))
  end


# Month with 30 Days
  def test_16_format_week0
    calendar = Cal.new(4, 2013)
    assert_equal("    1  2  3  4  5  6", calendar.format_week(0, 4, 2013))
  end

  def test_12b_format_week1
    calendar = Cal.new(4, 2013)
    assert_equal(" 7  8  9 10 11 12 13", calendar.format_week(1, 4, 2013))
  end

  def test_12c_format_week2
    calendar = Cal.new(4, 2013)
    assert_equal("14 15 16 17 18 19 20", calendar.format_week(2, 4, 2013))
  end

  def test_12d_format_week3
    calendar = Cal.new(4, 2013)
    assert_equal("21 22 23 24 25 26 27", calendar.format_week(3, 4, 2013))
  end

  def test_12e_format_week4
    calendar = Cal.new(4, 2013)
    assert_equal("28 29 30            ", calendar.format_week(4, 4, 2013))
  end

  def test_12f_format_week5
    calendar = Cal.new(4, 2013)
    assert_equal("                    ", calendar.format_week(5, 4, 2013))
  end

  def test_13a_format_week0
    calendar = Cal.new(5, 2013)
    assert_equal("          1  2  3  4", calendar.format_week(0, 5, 2013))
  end

  def test_13b_format_week1
    calendar = Cal.new(5, 2013)
    assert_equal(" 5  6  7  8  9 10 11", calendar.format_week(1, 5, 2013))
  end

  def test_13c_format_week2
    calendar = Cal.new(5, 2013)
    assert_equal("12 13 14 15 16 17 18", calendar.format_week(2, 5, 2013))
  end

  def test_13d_format_week3
    calendar = Cal.new(5, 2013)
    assert_equal("19 20 21 22 23 24 25", calendar.format_week(3, 5, 2013))
  end

  def test_13e_format_week4
    calendar = Cal.new(5, 2013)
    assert_equal("26 27 28 29 30 31   ", calendar.format_week(4, 5, 2013))
  end

  def test_13f_format_week5
    calendar = Cal.new(5, 2013)
    assert_equal("                    ", calendar.format_week(5, 5, 2013))
  end

  def test_14_format_month
    calendar = Cal.new(5, 2013)
    assert_equal("          1  2  3  4\n 5  6  7  8  9 10 11\n12 13 14 15 16 17 18\n19 20 21 22 23 24 25\n26 27 28 29 30 31    \n                    ", calendar.format_month(5, 2013))
  end

  def test_15_print_year_header
    calendar = Cal.new("3", "2013")
    assert_equal("2013".center(64), calendar.print_year_header(2013))
  end

  def test_16_print_3_month_header
    calendar = Cal.new("3", "2013")
    assert_equal("January".center(20) + "  " + "February".center(20) + "  " + "March".center(20), calendar.print_3_month_header(1))
  end

  def test_17_print_3_month_week_header
    calendar = Cal.new("3", "2013")
    assert_equal("Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa", calendar.print_3_month_week_header)
  end

  def test_18_format_3_month_week_1
    calendar = Cal.new("3", "2013")
    assert_equal("       1  2  3  4  5                  1  2                  1  2", calendar.format_weeks_for_3_months(0, 2013))
  end

  def test_19_print_3_month_week_2
    calendar = Cal.new("3", "2013")
    assert_equal(" 6  7  8  9 10 11 12   3  4  5  6  7  8  9   3  4  5  6  7  8  9", calendar.format_weeks_for_3_months(1, 2013))
  end
end

