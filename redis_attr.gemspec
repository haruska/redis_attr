# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redis_attr/version'

Gem::Specification.new do |spec|
  spec.name          = "redis_attr"
  spec.version       = RedisAttr::VERSION
  spec.authors       = ["Jason Haruska"]
  spec.email         = ["jason@haruska.com"]
  spec.description   = %q{Ruby model attributes backed by redis}
  spec.summary       = %q{An opinionated Redis::Objects}
  spec.homepage      = "https://github.com/haruska/redis_attr"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", ">= 3.0.2", "< 4.1"
  spec.add_runtime_dependency "redis-objects"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "shoulda-context"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "active_attr"
  spec.add_development_dependency "activerecord"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "faker"
  spec.add_development_dependency "minitest"
end
