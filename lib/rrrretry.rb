# We're monkey patching Enumerable Directly

# See Enumerable
module Rrrretry
end

module Enumerable
  # Attempts to run code for every element, returns the first valid run.
  # If code does not return, the original error will be raised.
  #
  # First run returns a `divided by 0` error, so the next result is returned.
  #
  #  [0, 1, 2].each.retry { |i| 1/i }
  #  # => 1
  #
  # If there are no valid returns, the last error will be raised.
  #
  #  [0, 1, 2].each.retry { raise "bar" }
  #  # => RuntimeError: bar
  #
  # By default only `StandardError` is caught, multiple error types can be
  # specified.
  #
  #  array = [->{ raise Exception }, ->{ raise SignalException }, ->{ 1 }]
  #  array.each.retry(Exception, SignalException) { |i| i.call }
  #  # => 1
  def retry(*exceptions, &block)
    exceptions     << StandardError if exceptions.empty?
    enum           = self.to_enum
    last_exception = nil

    while true do
      begin
        value = enum.next
      rescue StopIteration => e
        raise  last_exception if last_exception
        return false
      end

      begin
        return yield value
      rescue *exceptions => e
        last_exception = e
      end
    end
  end
end
