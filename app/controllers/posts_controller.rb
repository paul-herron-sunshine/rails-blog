class PostsController < ApplicationController
  include SessionsHelper
  def index
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user_id=current_user
  end

  def create
    # render plain: params[:post].inspect
    @post = Post.new(post_params)

    @post.save
    #loads show view:
    redirect_to @post
  end

  private def post_params
    params.require(:post).permit(:user_id, :title, :body)
  end

end
