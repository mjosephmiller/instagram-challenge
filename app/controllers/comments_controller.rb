class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def new
    @picture = Picture.find(params[:picture_id])
    @comment = Comment.new
  end

  def create
    @picture = Picture.find(params[:picture_id])
    @picture.comments.create(review_params)
    redirect_to pictures_path
  end

  private

  def review_params
    params.require(:comment).permit(:comments)
  end
end
