require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper.rb'))

module RedisAttr
  class ModelTest < Test::Unit::TestCase
    setup do
      @run = FactoryGirl.create(:my_run)
    end

    teardown do
      @run.set_redis_keys_expire(1)
    end

    should 'keep track of redis attribute names' do
      [:jobs_remaining_counter, :next_high_watermark, :still_active].each do |attr|
        assert @run.redis_attributes.include?(attr), "#{attr} not included in #{@run.redis_attributes}"
      end
    end

    should 'add helper method for counters that returns current integer value' do
      assert_equal @run.jobs_remaining_counter.value.to_i, @run.jobs_remaining
    end

    should 'clean redis attributes' do
      @run.redis_attributes.each {|a| assert_equal -1, @run.send(a).ttl}

      @run.clean_redis_attributes

      @run.redis_attributes.each do |a|
        assert @run.send(a).ttl > 0
        assert @run.send(a).ttl <= 60
      end
    end

    should 'hook into after_destroy if exists' do
      @run.redis_attributes.each {|a| assert_equal -1, @run.send(a).ttl}

      @run.destroy

      @run.redis_attributes.each do |a|
        assert @run.send(a).ttl > 0
        assert @run.send(a).ttl <= 60
      end
    end
  end
end
