class PostsController < ApplicationController
  include SessionsHelper
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
  end

  def create
    # render plain: params[:post].inspect
    @post = Post.new(post_params)
    @post.save
    #loads show view:
    redirect_to @post
  end

  def destroy
        # destroy method deletes record from db
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Your post was successfully deleted.' }
      format.json { head :no_content }
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
