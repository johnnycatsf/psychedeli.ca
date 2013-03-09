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

[ActionDispatch::IntegrationTest, ActionController::TestCase].each do |clz|
  clz.class_eval do
    def assert_redirected_to(options = {}, message=nil)
      assert_response(:redirect, message)
      return true if options == @response.location

      redirect_is       = normalize_argument_to_redirection(@response.location)
      redirect_expected = normalize_argument_to_redirection(options)

      message ||= "Expected response to be a redirect to <#{redirect_expected}> but was a redirect to <#{redirect_is}>"
      assert_equal redirect_expected, redirect_is, message
    end

    def assert_template(options = {}, message = nil)
      case options
      when NilClass, String, Symbol
        options = options.to_s if Symbol === options
        rendered = @templates
        msg = message || sprintf("expecting <%s> but rendering with <%s>",
                options, rendered.keys)
        a_val = if options
          rendered.any? { |t,num| t.match(options) }
        else
          @templates.blank?
        end
        assert(a_val, msg)
      when Hash
        if expected_layout = options[:layout]
          msg = message || sprintf("expecting layout <%s> but action rendered <%s>",
                  expected_layout, @layouts.keys)

          case expected_layout
          when String
            assert_includes @layouts.keys, expected_layout, msg
          when Regexp
            assert(@layouts.keys.any? {|l| l =~ expected_layout }, msg)
          when nil
            assert(@layouts.empty?, msg)
          end
        end

        if expected_partial = options[:partial]
          if expected_locals = options[:locals]
            actual_locals = @locals[expected_partial.to_s.sub(/^_/,'')]
            expected_locals.each_pair do |k,v|
              assert_equal(v, actual_locals[k])
            end
          elsif expected_count = options[:count]
            actual_count = @partials[expected_partial]
            msg = message || sprintf("expecting %s to be rendered %s time(s) but rendered %s time(s)",
                     expected_partial, expected_count, actual_count)
            assert(actual_count == expected_count.to_i, msg)
          else
            msg = message || sprintf("expecting partial <%s> but action rendered <%s>",
                    options[:partial], @partials.keys)
            assert_includes @partials, expected_partial, msg
          end
        else
          assert @partials.empty?,
            "Expected no partials to be rendered"
        end
      end
    end
    def assert_response(type, message = nil)
      message ||= "Expected response to be a <#{type}>, but was <#{@response.response_code}>"

      if Symbol === type
        if [:success, :missing, :redirect, :error].include?(type)
          assert @response.send("#{type}?"), message
        else
          code = Rack::Utils::SYMBOL_TO_STATUS_CODE[type]
          assert_equal code, @response.response_code, message
        end
      else
        assert_equal type, @response.response_code, message
      end
    end
  end
end
