class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :verify_user, only: [:show]

  def show
   @user
  end

  def new
  end

  def create
    user = User.create!(user_params)
    if user.save
      flash[:alert] = "Welcome #{user.name}!"
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else
      flash[:alers] = "Please enter a valid name and email."
      redirect_to "/register"
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(session[:user_id])
  end

  def verify_user
    if !current_user 
      flash[:alert] = "You must be signed in and/or register in order to access the page yu are trying to reach"
      redirect_to root_path
    end
  end
end