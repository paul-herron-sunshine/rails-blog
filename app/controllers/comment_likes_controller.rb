Rails.logger.debug

class CommentLikesController < ApplicationController

  def create
	
	@commentLike = CommentLike.new({:comment_id => params[:comment_id], :user_id => params[:user_id]})

	@comment = Comment.find(params[:comment_id])

    if @commentLike.save
	    respond_to do |format|
	      format.html { redirect_to post_comments_url, notice: 'Comment liked.' }
	      format.json { head :no_content }
		end   
    end
  end

end
