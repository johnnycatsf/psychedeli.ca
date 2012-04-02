ENV['RACK_ENV'] = "test"

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'turn'
require 'minitest/autorun'
require 'active_support/all'
require 'mini_shoulda'
require 'vcr'
require 'webmock'
require 'rack/test'

VCR.configure do |c|
  c.default_cassette_options = { :record => :new_episodes }
  c.cassette_library_dir = File.expand_path './test/cassettes/'
  c.hook_into :webmock
end

class UnitTest < ActiveSupport::TestCase

end

class IntegrationTest < ActiveSupport::TestCase
  include Rack::Test::Methods
end


Turn.config.format = :dot # :progress
