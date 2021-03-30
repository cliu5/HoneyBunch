require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  before :each do
    @user = User.create(:username => 'test', :password => 'test') #changed but idt it matters
    session[:user_id] = @user.id
    log_in(@user)
    end
  
    describe 'login' do
      it 'logs in' do
        expect(session[:user_id]).to eq(@user.id)
      end
    end

    describe 'logout' do
      it 'logs out' do
        log_out 
        expect(@current_user).to eq(nil)
      end
    end

    describe 'logged in?' do
      it 'is logged in' do
        expect(logged_in?).to eq(true)
      end
      it 'is not logged in' do
        log_out
        expect(logged_in?).to eq(false)
      end
    end

    describe 'current_user' do
      it 'is equal to current user' do
        expect(current_user).to eq(User.find_by(id: session[:user_id]))
      end
    end

end
