class AboutController < ApplicationController
  def index
    @user_logged_in = session[:user_id].present?
    if @user_logged_in
      @user = User.find(session[:user_id])
    end
  end
end
