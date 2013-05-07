require 'test/unit'
require './ruby-cal.rb'

class CalIntegrationTest < Test::Unit::TestCase

  def test_01_cal_takes_arguments
    assert_equal(`cal 2 2013`, `ruby ruby-cal.rb 2 2013`)
   end

  def test_02_month_with_30_days
    assert_equal(`cal 4 2013`, `ruby ruby-cal.rb 4 2013`)
  end

  def test_03_month_with_31_days
    assert_equal(`cal 5 2013`, `ruby ruby-cal.rb 5 2013`)
  end

  def test_05_month_with_4_weeks
    assert_equal(`cal 2 2009`, `ruby ruby-cal.rb 2 2009`)
  end

  def test_06_month_with_6_weeks
    assert_equal(`cal 3 2013`, `ruby ruby-cal.rb 3 2013`)
  end

  def test_07_common_year_past
    assert_equal(`cal 2 1800`, `ruby ruby-cal.rb 2 1800`)
  end

  def test_08_common_year_future
    assert_equal(`cal 2 2200`, `ruby ruby-cal.rb 2 2200`)
  end

  def test_09_leap_year_past
    assert_equal(`cal 2 1804`, `ruby ruby-cal.rb 2 1804`)
  end

  def test_10_leap_year_future
    assert_equal(`cal 2 2400`, `ruby ruby-cal.rb 2 2400`)
  end

  def test_11a_print_full_year
  	assert_equal(`cal 2013`, `ruby ruby-cal.rb 2013`)
  end 

  def test_11b_print_full_year
    assert_equal(`cal 2000`, `ruby ruby-cal.rb 2000`)
  end 
end
