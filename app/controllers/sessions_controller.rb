class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:user][:email]
    password = params[:user][:password]

    if @user == User.authenticate_with_credentials(email, password)
      session[:user_id] = @user.id
      redirect_to :root
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
