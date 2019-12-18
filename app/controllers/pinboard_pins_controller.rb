class PinboardPinsController < ApplicationController
  def index
    @user_logged_in = session[:user_id].present?
    if @user_logged_in
      @user = User.find(session[:user_id])
    else
      redirect_to new_user_path
    end
  end

  def create
    user = User.find(params[:user_id])
    pin = Pin.find(params[:pin_id])
    user.pinboard_pins << pin
    redirect_to pin_path(pin)
  end
end
