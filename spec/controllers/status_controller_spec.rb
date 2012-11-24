require 'spec_helper'

describe StatusController do
  describe "StatusController: GET /status.json" do
    setup do
      VCR.use_cassette(:all_services) do
        get :index, format: :json
      end
    end

    it "accept JSON requests" do
      response.status.should == 200
    end

    it "respond with an array of JSON objects" do
      statuses = JSON.parse response.body
      refute_empty statuses
    end
  end

  %w(html xml).each do |fmt|
    describe "StatusController: GET /status.#{fmt}" do
      setup do
        VCR.use_cassette(:all_services) do
          get :index, format: fmt.to_sym
        end
      end

      it "reject #{fmt.upcase} requests" do
        response.status.should == 406
      end

      it "respond with a blank body" do
        response.body.blank?, "Body has content".should.not == nil
      end
    end
  end
end
