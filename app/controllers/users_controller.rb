class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.find_or_create_by(user_params)
    if @user.id.nil?
      render 'new'
    else
      session[:user_id] = @user.id
      redirect_to about_index_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
