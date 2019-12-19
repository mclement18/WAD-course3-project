class PinsController < ApplicationController
  def index
    @user_logged_in = user_logged_in?
    if @user_logged_in
      @user = current_user
    end
    @query = params[:q]
    @pins = Pin.search(@query)
  end

  def new
    @user_logged_in = user_logged_in?
    if @user_logged_in
      @user = current_user
      @pin = Pin.new
    else
      redirect_to new_user_path
    end
  end

  def create
    @user_logged_in = user_logged_in?
    @user = current_user
    @pin = Pin.new(pin_params)
    @pin.user = @user
    if @pin.save
      @user.pinboard_pins << @pin
      redirect_to pins_path
    else
      render 'new'
    end
  end

  def show
    @pin = Pin.find(params[:id])
    @comment = Comment.new
    @user_logged_in = user_logged_in?
    if @user_logged_in
      @user = current_user
      @disable_add_pin = @user.pinboard_pins.exists?(@pin.id)
    end
  end

  def edit
    @user_logged_in = user_logged_in?
    if @user_logged_in
      @user = current_user
      @pin = Pin.find(params[:id])
    else
      redirect_to new_user_path
    end
  end

  def update
    @user_logged_in = user_logged_in?
    @user = current_user
    @pin = Pin.find(params[:id])
    if @pin.update(pin_params)
      redirect_to pin_path(@pin)
    else
      render 'edit'
    end
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :image_url, :tag)
  end
end
