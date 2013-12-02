require 'test_helper'

class Rrrrretry_test < Test::Unit::TestCase
  Enumerator = [].each.class

  class GenericEnumerable
    include Enumerable
    def initialize(values = [1, 2, 3])
      @values = values
    end

    def each
      @values.each{|v| yield v}
    end
  end

  def test_retry
    assert_equal 0.5, GenericEnumerable.new([ 2.0, 0 ]).retry { |i| 1/i }
    assert_equal 1,   GenericEnumerable.new([ 0,   1 ]).retry { |i| 1/i }
    assert_raise(ZeroDivisionError) {GenericEnumerable.new([0]).retry { |i| 1/i } }
    result = GenericEnumerable.new([ Exception, 1 ]).retry(Exception) do |i|
      raise i if i == Exception
      i
    end
    assert_equal 1, result
    result = GenericEnumerable.new([ Exception, SecurityError, 1 ]).retry(Exception, SecurityError) do |i|
      raise i if i == Exception || i == SecurityError
      i
    end
    assert_equal 1, result
    GenericEnumerable.new([]).retry {} # ensure no errors
  end

  def test_raising_stop_iteration
    assert_raise(StopIteration) do
      2.times.retry do
        raise StopIteration
      end
    end

    assert_raise(StopIteration) do
      1.times.retry do
        raise StopIteration
      end
    end
  end
end
