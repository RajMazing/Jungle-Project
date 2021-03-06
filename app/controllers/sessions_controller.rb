class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:current_user] = user
      redirect_to :root

    else 
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:current_user] = nil
    redirect_to :root
  end

end 