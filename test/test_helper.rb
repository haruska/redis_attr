require 'bundler/setup'

require 'test/unit'
require 'shoulda-context'
require 'factory_girl'
require 'active_attr'
require 'active_attr/model'
require 'faker'
require 'active_record'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'unit'))

require 'redis_attr'

ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => File.expand_path(File.dirname(__FILE__) + '/testing_redis_attr.sqlite3')
)

ActiveRecord::Schema.define do
  create_table :my_runs, :force => true
end

class MyRun < ActiveRecord::Base
  include Redis::Objects
  include RedisAttr::Model

  counter :jobs_remaining
  hash_key :next_high_watermark
  value :still_active, :default => true
end

FactoryGirl.define do
  factory :my_run do
    after(:create) do |r|
      r.jobs_remaining_counter.incr(rand(5))
      r.next_high_watermark[Faker::Lorem.word] = Faker::Lorem.sentence
    end
  end
end
