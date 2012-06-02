require 'spec_helper'

describe ProfilesController do

  let(:user1) {create_user!(email: "user1@ticketee.com",password: "password")}
  let(:user2) {create_user!(email: "user2@ticketee.com",password: "password")}

  describe "Standard User" do
    before do
      sign_in :user,user1
    end

    it "cannot edit the profile of the other user" do
      send :get,:edit,user_id: user2.id
      response.should redirect_to(index_url)
      flash[:alert].should eql("You do not have permission to update the profile of that user.")
    end

    it "cannot update the profile of the other user" do
      send :put,:update,user_id: user2.id
      response.should redirect_to(index_url)
      flash[:alert].should eql("You do not have permission to update the profile of that user.")
    end
  end

end
