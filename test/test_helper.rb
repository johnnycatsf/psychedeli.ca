ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'bundler'
Bundler.require :default, :test

VCR.configure do |c|
  c.cassette_library_dir = "#{Rails.root}/test/fixtures/cassettes"
  c.hook_into :webmock # or :fakeweb
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  #fixtures :all

  # Add more helper methods to be used by all tests here...
end

ActionDispatch::Assertions::ResponseAssertions.instance_eval do
  # Override so deprecation warnings stop popping up. This uses a proper
  # +assert+ method but retains the functionality of +assert_response+.
  define_method(:assert_response_test) do |expected_status|
    response_status = response.send :status
    assert_equal response_status, expected_status, "Expected response to be <#{expected_status}>, but was <#{response_status}>" 
  end
end
