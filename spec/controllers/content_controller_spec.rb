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

    it "should return the existing content" do
      request
      @content = Content.get_by_id(1, status: Content::Status[:public])
      assigns(:content).should eq(@content)
    end
  end

  describe "#auth_create get" do
    let(:request) { get :auth_create }
    it "should return status 200 and render auth_edit" do
      request
      response.status.should == 200
      response.should render_template("auth_edit")
    end
  end

  describe "#auth_create post" do
    let(:request) { post :auth_create, params }
    context "when input valid data" do
      let(:params) { { content: attributes_for(:content) } }
      it "should return status 200 and render auth_edit" do
        request
        response.status.should == 200
        response.should render_template("auth_edit")
      end

      it "create the new record" do
        request
        assigns(:content).errors.should be_empty
        assigns(:content).should be_persisted
      end
    end
  end

  describe "#auth_edit get" do
    let(:request) { get :auth_edit, { id: 1 } }
    it "should return status 200 and render show" do
      request
      response.status.should == 200
      response.should render_template("auth_edit")
    end

    it "should return the existing content" do
      request
      @content = Content.get_by_id(1)
      assigns(:content).should eq(@content)
    end
  end
end
