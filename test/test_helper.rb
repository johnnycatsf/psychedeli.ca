ENV['RACK_ENV'] = "test"

# The classes we are testing
$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'status_exchange'
# require 'autocorrect'

# Test suite
require 'minitest/autorun'
require 'mini_shoulda'
require 'active_support/all'
require 'rack/test'
require 'turn'

# HTTP mocking
require 'vcr'
require 'webmock'
VCR.config do |c|
  c.cassette_library_dir = File.expand_path './test/cassettes/'
  c.stub_with :webmock
end


# Test output configuration
ENV['BAR'] and Turn.config.format = :progress
ENV['DOT'] and Turn.config.format = :dot

# Global test controller
class ActiveSupport::TestCase
  def yaml_config
    YAML::load_file(File.expand_path('./cfg/status_exchange.yml')).symbolize_keys!
  end
  def cfg
    yaml_config
  end
end
