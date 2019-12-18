class AboutController < ApplicationController
  def index
    @user_logged_in = session[:user_id].present?
  end
end
