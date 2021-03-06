# rrrretry
[![Help Contribute to Open Source](https://www.codetriage.com/schneems/rrrretry/badges/users.svg)](https://www.codetriage.com/schneems/rrrretry)

Because `retry` was already taken.

## Install

In your `Gemfile` add:

```ruby
gem 'rrrretry'
```

Then run `bundle install`.

## What Does it Do?

Monkey patches Enumerable to add a method called `retry` that attempts to run code for every element, returns the first valid run.

If code does not return, the original error will be raised.

## Whoa Crazy! Give me an example:

Most people will use it for network communication like this:

```ruby
10.times.retry do
  SomeNetworkCommunicationThingyHere.new
end
```

But if you prefer runnable examples check these out:

First run returns a `divided by 0` error, so the next result is returned.

```ruby
[0, 1, 2].each.retry { |i| 1/i }
  # => 1
```

If there are no valid returns, the last error will be raised.

```ruby
[0, 1, 2].each.retry { raise "bar" }
  # => RuntimeError: bar
```

By default only `StandardError` is caught, multiple error types can be
specified.

```ruby
array = [->{ raise Exception }, ->{ raise SignalException }, ->{ 1 }]
array.each.retry(Exception, SignalException) { |i| i.call }
  # => 1
```

For the sake of reporting, previous exceptions are passed to the block.

```ruby
[0, 1].each.retry do |i, ex|
  puts "LOG: Retrying due to exception: #{ex.to_s}" unless ex.nil?
  raise "bar"
end
  # => LOG: Retrying due to exception: bar
  # => RuntimeError: bar
```

## Is it Complex?

Naw, it's 8 lines of ruby:

```ruby
def retry(*exceptions, &block)
  exceptions << StandardError if exceptions.empty?
  enum       ||= self.to_enum
  yield enum.next
rescue *exceptions => e
  last_exception = e and retry unless e.is_a? StopIteration
  raise last_exception unless last_exception.nil?
end
```

## Why?

Because I needed this code in more than one project, I didn't like the other solutions, and because coding is fun.

## Isn't Monkey Patching Evil?

Yes. Do as I say, not as I do.

## License

MIT YO. See [MIT-LICENSE](https://github.com/schneems/rrrretry/blob/master/MIT-LICENSE) for more info.

