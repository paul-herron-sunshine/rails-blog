class CommentsController < ApplicationController
  
  def new
    @comment = Comment.new
  end
  
  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params)
    if 
      @comment.save
    else
      render 'new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
