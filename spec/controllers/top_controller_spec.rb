require 'spec_helper'

# bundle exec rspec -cfs spec/controllers/top_controller_spec.rb
describe TopController do
  describe "#index" do
    let(:req) { get :index }
    it "should return status 200 and render show" do
      req
      response.status.should == 200
      response.should render_template("index")
    end
  end
end
