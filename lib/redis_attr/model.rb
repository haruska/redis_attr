require 'active_support/concern'
require 'redis-objects'

module RedisAttr
  module Model
    extend ActiveSupport::Concern

    included do
      after_destroy :clean_redis_attributes if respond_to?(:after_destroy)
    end

    def redis_attributes
      self.class.redis_attributes
    end

    def set_redis_keys_expire(seconds = 3.days)
      self.redis_attributes.each do |attr|
        send(attr).expire(seconds)
      end
    end

    def clean_redis_attributes
      set_redis_keys_expire(1.minute)
    end

    module ClassMethods
      attr_writer :redis_attributes
      def redis_attributes
        @redis_attributes ||=[]
      end


      def counter(name, opts={})
        counter_name = "#{name}_counter".to_sym
        super counter_name, opts
        define_method(name) { send(counter_name).to_i }

        self.redis_attributes << counter_name
      end

      def hash_key(name, opts={})
        super name, opts
        self.redis_attributes << name
      end

      def value(name, opts={})
        super name, opts
        self.redis_attributes << name
      end
    end
  end
end

