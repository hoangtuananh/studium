require 'spec_helper'

describe Admin::Materials::BaseController do

  describe "Guest" do
    it "should not have access to any aciton in this controller" do
      get :index
      response.should redirect_to(index_path)
      flash[:alert].should eql("The page you were looking for could not be found.")
    end
  end

  describe "Standard User" do
    let(:user){create_user! email: "user@ticktee.com",password: "password"}

    before do
      sign_in :user,user
    end
      
    it "should not have access to any action in this controller" do
      get :index
      response.should redirect_to(index_path)
      flash[:alert].should eql("The page you were looking for could not be found.")
    end
  end

end
