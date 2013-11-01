require 'spec_helper'

# bundle exec rspec -cfs spec/controllers/top_controller_spec.rb
describe TopController do
  describe "#index" do
    let(:request) { get :index }
    it "should return status 200 and render show" do
      request
      response.status.should == 200
      response.should render_template("index")
    end
  end
end
