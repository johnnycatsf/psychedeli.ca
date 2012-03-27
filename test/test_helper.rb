ENV['RACK_ENV'] = "test"

# The classes we are testing
$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'status_exchange'

require 'turn'
require 'minitest/autorun'

require 'active_support/all'
require 'mini_shoulda'
require 'vcr'
require 'webmock'

require 'rack/test'
require 'capybara'

VCR.configure do |c|
  c.cassette_library_dir = File.expand_path './test/cassettes/'
  c.hook_into :webmock
end

class UnitTest < ActiveSupport::TestCase

end

class IntegrationTest < ActiveSupport::TestCase
  include Rack::Test::Methods
  # include ActionDispatch::Assertions::ResponseAssertions

  setup { @request = Rack::MockRequest.new }
end

ENV['BAR'] and Turn.config.format = :progress
ENV['DOT'] and Turn.config.format = :dot
