require 'spec_helper'

describe Admin::Materials::QuestionsController do

  describe "Guest" do
    {get: "index",get: "new",post: "create",get: "category_selection"}.each do |method,action|
      it "should not have access to any action in this controller" do
        send method,action
        response.should redirect_to(index_path)
        flash[:alert].should eql("The page you were looking for could not be found.")
      end
    end
  end

  describe "Standard User" do
    let(:user){create_user! email: "user@ticktee.com",password: "password"}

    before do
      sign_in :user,user
    end

    {get: "index",get: "new",post: "create",get: "category_selection"}.each do |method,action|
      it "should not have access to any action in this controller" do
        send method,action
        response.should redirect_to(index_path)
        flash[:alert].should eql("The page you were looking for could not be found.")
      end
    end
  end
end
