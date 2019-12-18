class PinsController < ApplicationController
  def index
    @user_logged_in = session[:user_id].present?
    @query = params[:q]
    @pins = Pin.search(@query)
  end

  def new
    @user_logged_in = session[:user_id].present?
    if @user_logged_in
      @pin = Pin.new
    else
      redirect_to new_user_path
    end
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
    @comment = Comment.new
    @user_logged_in = session[:user_id].present?
    if @user_logged_in
      @user = User.find(session[:user_id])
      @disable_add_pin = false # @user.pinboard.exists?(@pin.id)
    end
  end

  def edit
    @user_logged_in = session[:user_id].present?
    if @user_logged_in
      @pin = Pin.find(params[:id])
    else
      redirect_to new_user_path
    end
  end

  def update
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
