class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.where(post_id: params[:post_id]) 
    if Post.exists?(params[:post_id])
      @post = Post.find(params[:post_id]) 
      @title = "All comments for &ldquo;" + @post.title + "&rdquo;"
      @title = @title.html_safe
    else 
      render_not_found
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id]) 
    @title = "Say something about &ldquo;" + @post.title + "&rdquo;"
    @title = @title.html_safe
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id]) 
    @title = "Editing comment for &ldquo;" + @post.title + "&rdquo;"
    @title = @title.html_safe
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@comment.post, @comment], notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to [@comment.post, @comment], notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: [@comment.post, @comment] }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def render_not_found
    render :file => "/public/404.html",  :status => 404
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.fetch(:comment, {})
      params.require(:comment).permit(:body, :user_id, :post_id)
    end
end
