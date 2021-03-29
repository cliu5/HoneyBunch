require 'rails_helper'
include SessionsHelper

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      @user = User.create(:username => 'test', :password => 'test') #changed but idt it matters
      session[:user_id] = @user.id
      log_in(@user)
      get :create
      expect(response).to have_http_status(:success) #can change this to 302 to pass
    end
  end


  describe "GET #login" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #welcome" do
    it "returns http success" do
      get :welcome
      expect(response).to have_http_status(:success)
    end
  end

end