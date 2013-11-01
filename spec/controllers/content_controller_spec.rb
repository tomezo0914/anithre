require 'spec_helper'

# bundle exec rspec -cfs spec/controllers/content_controller_spec.rb
describe ContentController do
  render_views

  describe "#show" do
    let(:request) { get :show, { id: 1 } }
    it "should return status 200 and render show" do
      request
      response.status.should == 200
      response.should render_template("show")
    end

    it "should return the existing curation" do
      request
      @content = Content.get_by_id(1, status: Content::Status[:public])
      assigns(:content).should eq(@content)
    end
  end
end
