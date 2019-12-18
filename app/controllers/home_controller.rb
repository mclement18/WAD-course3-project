class HomeController < ApplicationController
  def index
    @user_logged_in = session[:user_id].present?
    @pins = Pin.most_recent
  end
end
