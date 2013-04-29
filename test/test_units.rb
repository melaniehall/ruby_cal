require 'test/unit'
require './ruby-cal.rb'

class CalTest < Test::Unit::TestCase

  def test_01_initialize_stores_month
    calendar = Cal.new(5, 2013)
    assert_equal(5, calendar.month)
  end

  def test_02_initialize_stores_month
    calendar = Cal.new(5, 2013)
    assert_equal(2013, calendar.year)
  end

end