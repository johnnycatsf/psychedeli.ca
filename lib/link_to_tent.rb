# Make an HTTP Header Link to the Tent server, so Tent users
# can contact me via psychedeli.ca/ instead of t.psychedeli.ca/
class LinkToTent

  # The tent server that will be Linked to
  TENT_URL = "https://t.psychedeli.ca/profile"

  def call env
    status, headers, response = @app.call env
    headers['Link'] = %[<#{TENT_URL}>; rel="#{TENT_URL}"]
    [status, headers, response]
  end
end
