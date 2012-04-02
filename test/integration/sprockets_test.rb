require 'test_helper'
require 'sprockets'

class SprocketsTest < IntegrationTest
  context "Stylesheets in /app/css" do
    setup {
      @stylesheets = Sprockets::Environment.new
      @stylesheets.append_path 'app/css'
    }

    should "serve the compiled stylesheet manifest" do
      get 'application.css'
      assert last_response.ok?, last_response.inspect
    end
  end

  context "Javascripts in /app/js" do
    setup {
      @javascripts = Sprockets::Environment.new
      @javascripts.append_path 'app/js'
    }

    should "serve the compiled javascript manifest" do
      get 'application.js'
      assert last_response.ok?, last_response.inspect
    end
  end

  private

  def app
    @stylesheets || @javascripts
  end
end
