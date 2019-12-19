class HomeController < ApplicationController
  def index
    @user_logged_in = user_logged_in?
    if @user_logged_in
      @user = current_user
    end
    @pins = Pin.most_recent
  end
end
