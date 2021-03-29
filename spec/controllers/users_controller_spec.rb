require 'rails_helper'
include SessionsHelper

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      @user = User.create(:username => 'test', :password => 'test')
      session[:user_id] = @user.id
      log_in(@user)
      controller.params[:user] = 'test'
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end
