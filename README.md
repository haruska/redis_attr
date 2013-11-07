# RedisAttr

RedisAttr builds on the great Redis::Objects project. It provides more meta-
programming info around the redis attributes, some nice helper methods for
grabbing the values, and ability to auto-cleanup redis on destroy of the 
object.

## Installation

Add this line to your application's Gemfile:

    gem 'redis_attr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redis_attr

## Usage

To use on any ruby object, just include `RedisAttr::Model`. It will then
provide you with enhanced Redis::Objects.

    class MyObj
      include RedisAttr::Model

      counter :num_calls
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
