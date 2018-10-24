Rails.logger.debug
class CommentLikesController < ApplicationController


  def create
	
	@commentLike = CommentLike.new({:comment_id => params[:comment_id], :user_id => params[:user_id]})

	@comment = Comment.find(params[:comment_id])
    respond_to do |format|
      if @commentLike.save
        format.html { redirect_to [@comment.post, @comment] }
      else 
        format.html { redirect_to [@comment.post, @comment] }
      end
    end	
  end

end
