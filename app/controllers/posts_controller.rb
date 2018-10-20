class PostsController < ApplicationController
  layout "posts"
  include SessionsHelper
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
    #sort here
    single_title = "Welcome to the OTB Academy Blogosphere"
  end

  def show
    @post = Post.find(params[:id])
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

      single_title = "Your post was successfully removed"
    end
    else
      flash[:danger] = "You can only delete articles that you have written"
      redirect_to posts_url
    end
  end

  private 
  
  def post_params
    params.require(:post).permit(:user_id, :title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
