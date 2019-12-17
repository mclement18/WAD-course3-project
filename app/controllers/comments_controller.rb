class CommentsController < ApplicationController
  def create
    @user = User.find(session[:user_id])
    @pin = Pin.find(params[:pin_id])
    @comment = Comment.new comment_params
    @comment.user = @user
    @comment.pin = @pin
    if @comment.save
      redirect_to pin_path(@pin)
    else
      render 'pins/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
