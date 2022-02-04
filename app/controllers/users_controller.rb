class UsersController < ApplicationController
  def new
  end

  def create  
    puts user_params
    user = User.new(user_params)


    if user.save
      session[:user_id] = user.id
      session[:current_user] = user
      redirect_to :root, notice: 'User created!'
    else
      render :new
    end
  end

  private

  def user_params
    params[:user][:name] = "#{params[:user][:first_name]} #{params[:user][:last_name]}"
    
    puts params[:name], "#{params[:first_name]} #{params[:last_name]}"
  
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )

  end
end
  