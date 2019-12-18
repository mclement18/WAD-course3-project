class UsersController < ApplicationController
  def new
    @user_logged_in = session[:user_id].present?
    if @user_logged_in
      user = User.find(session[:user_id])
      redirect_to user_pinboard_pins_path(user)
    else
      @user = User.new
    end
  end
  
  def create
    @user = User.find_or_create_by(user_params)
    if @user.id.nil?
      render 'new'
    else
      session[:user_id] = @user.id
      redirect_to user_pinboard_pins_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
