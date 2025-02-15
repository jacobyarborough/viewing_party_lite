class SessionsController < ApplicationController 
  def new
  end 
  
  def create
    user = User.find_by(email: params[:email]) 
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else 
      flash[:alerts] = 'Email and/or password are incorrect'
      redirect_to '/login'
    end
  end 

  def destroy 
    session.destroy 
    redirect_to '/'
  end 
end 