require 'rubygems'
require 'bundler'
Bundler.setup :default, :test, :status_exchange
Bundler.require :default, :test, :status_exchange

require 'status_exchange'

ENV['RACK_ENV'] = "test"

VCR.configure do |c|
  c.default_cassette_options = { :record => :new_episodes }
  c.cassette_library_dir = File.expand_path './test/cassettes/'
  c.hook_into :webmock
end

class UnitTest < ActiveSupport::TestCase; end

class IntegrationTest < ActiveSupport::TestCase
  include Rack::Test::Methods
end
