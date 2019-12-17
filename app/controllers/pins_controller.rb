class PinsController < ApplicationController
  def index
    @query = params[:q]
    @pins = Pin.search(@query)
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

  def show
    @pin = Pin.find(params[:id])
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :image_url, :tag)
  end
end
