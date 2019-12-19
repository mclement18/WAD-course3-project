class PinboardPinsController < ApplicationController
  def index
    @user_logged_in = user_logged_in?
    if @user_logged_in
      @user = current_user
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
