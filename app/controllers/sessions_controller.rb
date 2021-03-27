class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create, :welcome]
  
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id 
        redirect_to '/stores'
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
    
  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to '/welcome'
  end

  def welcome
    
  end

  def login
  end

  def page_requires_login
  end
  
end