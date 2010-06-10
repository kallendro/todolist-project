class UserSessionsController < ApplicationController
  def new
    @user_session = User.new
  end

  def create
    @user_session = User.find_by_username_and_password(params[:user][:username], params[:user][:password]) || User.new
    if @user_session.new_record?
      render :new
    else
      session[:user] = @user_session.id
      session[:myusername] = @user_session.username
      redirect_to root_path
    end
  end

end
