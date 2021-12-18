class PartiesController < ApplicationController
  before_action :verify_user

  def new
    @movie = {movie_id: params[:movie_id], title: params[:title], duration: params[:duration], image: params[:image]}
    @user_id = session[:user_id]
    @users = User.all
  end

  def create
    party = Party.create!(party_params)
    Invite.create!(user_id: params[:user], party_id: party.id)
    redirect_to "/dashboard"
  end

  private
  def party_params
    params.permit(:movie_id, :movie_title, :user_id, :duration, :start_date, :start_time, :image)
  end

  def verify_user
    if !current_user 
      flash[:alert] = "You must be signed in and/or register in order to access the page you are trying to reach"
      redirect_to '/discover'
    end
  end
end