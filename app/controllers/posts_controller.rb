class PostsController < ApplicationController
  layout "posts"
  include SessionsHelper
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @params = params
    @posts = if params[:term].present?
      Post.where("title LIKE ? or body LIKE ?", "%#{params[:term]}%", "%#{params[:term]}%")
    else
      if params[:sort] == "1"
        # Rails.logger.debug("\n\n\n\n-------------------------- \e[31m#{__method__}\e[39m sort1\n\n\n\n")
        Post.order("created_at DESC").all
      elsif params[:sort] == "2"
        Post.order("votes DESC").all
      elsif params[:sort] == "3"
        Post.order("title ASC").all
      else
        Post.order("created_at DESC").all
    end
  end
    single_title = "Welcome to the OTB Academy Blogosphere"
  end

  def single_user_index
    @parameters = params
    @posts = Post.where(user_id: params[:user_id])
    single_title = "Posts"
  end

  def show
    @post = Post.find(params[:id])
    @count = comment_count
    single_title = "Here's the article"
  end

  def new
  end

  def create
    # render plain: params[:post].inspect
    @post = Post.new(post_params)
    @post.save
    single_title = "Your post was successful!"
    #loads show view:
    redirect_to @post
  end

  def destroy
    if @post.user_id == current_user.id    # destroy method deletes record from db
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
      flash[:success] = "Your post was successfully deleted"

      single_title = "Your post was successfully emoved"
    end
    else
      flash[:danger] = "You can only delete articles that you have written"
      redirect_to posts_url
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attribute(:votes, @post.votes ? @post.votes + params[:value].to_i : 1)
    redirect_to @post
  end

  def comment_count
    @count = Comment.where("post_id = ?", params[:id]).count
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :title, :body, :term)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
