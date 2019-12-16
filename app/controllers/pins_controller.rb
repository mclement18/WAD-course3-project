class PinsController < ApplicationController
  def index
  end

  def new
    @pin = Pin.new
  end

  def create
    @pin = Pin.new(pin_params)
    @pin.user = User.find(session[:user_id])
    if @pin.save
      redirect_to pins_path
    else
      render 'new'
    end
  end
end
