require 'spec_helper'

describe StatusController do
  describe "StatusController: GET /status.json" do
    setup do
      VCR.use_cassette(:all_services) { get :index, format: :json }
    end

    it "accept JSON requests" do
      response.should be_success
    end

    it "respond with an array of JSON objects" do
      response.body.should be_empty
    end
  end

  %w(html xml).each do |fmt|
    describe "StatusController: GET /status.#{fmt}" do
      it "rejects #{fmt.upcase} requests" do
        get :index, format: fmt.to_sym

        response.should be_failure
        response.body.should be_blank, "Body has content"
      end
    end
  end
end
