require 'test_helper'

class SprocketsTest < IntegrationTest
  attr_reader :app

  setup do
    @app = Sprockets::Environment.new
    @app.append_path 'app/css'
    @app.append_path 'app/js'
  end

  should "serve the compiled stylesheet manifest" do
    get 'application.css'
    assert last_response.ok?, last_response.inspect
  end

  should "serve the compiled javascript manifest" do
    get 'application.js'
    assert last_response.ok?, last_response.inspect
  end
end
