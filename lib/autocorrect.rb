# Throws a 404 error when called. It will be used in the future for all HTTP error management.
class Autocorrect
  def initialize(application)
    @app = application
  end

  def call(env)
    lambda {[404, {'Content-Type' => 'text/html'}, ['Not Found']]}
  end
end
