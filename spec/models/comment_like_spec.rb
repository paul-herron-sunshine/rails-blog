require 'rails_helper'

RSpec.describe CommentLike, type: :model do

  before :each do    

  	@user = User.new
  	@user = User.new(id: "1", name: "Test User", email: "user@test.com", password: "password", password_confirmation: "password")
  	@user.save

  	@post = Post.new
  	@post = Post.new(title: "Test Post", body: "test test", user_id: "1")
  	@post.save

  	@comment = Comment.new
    @comment = Comment.new(id: "2", user_id: "1", post_id: "1", body: "test test test")
    @comment.save

  	@commentLike = CommentLike.new
    @commentLike = CommentLike.new(id: "1", user_id: "1", comment_id: "2")
  end

  it "tests that our comment entry is valid" do
    expect(@user.valid?).to be true
    expect(@post.valid?).to be true
    expect(@comment.valid?).to be true
    expect(@commentLike.valid?).to be true
  end

  it "comment body cannot be empty" do
    @comment.body = ""
    expect(@comment.valid?).to be false
  end



end
