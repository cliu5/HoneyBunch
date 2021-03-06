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
    let!(:param) {{:username => 'test', :password => 'test'}}
    let!(:user) {User.create!(param)}
    it "returns http success" do
      get :create, :user => param
      expect(response).to have_http_status(302) #
    end
  end

end
