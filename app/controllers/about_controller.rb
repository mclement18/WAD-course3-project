class AboutController < ApplicationController
  def index
    @user_logged_in = user_logged_in?
    if @user_logged_in
      @user = current_user
    end
  end
end
