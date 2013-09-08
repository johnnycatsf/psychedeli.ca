if defined? Airbrake
  Airbrake.configure do |config|
    config.api_key = ENV['AIRBRAKE_API_KEY'] 
  end
else
  logger.debug "Warning: Airbrake is not defined" unless Rails.env.test?
end
