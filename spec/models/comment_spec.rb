require 'rails_helper'

RSpec.describe Comment, type: :model do

  before :each do    

  	@user = User.new
  	@user = User.new(name: "Test User", email: "user@test.com", password: "password", password_confirmation: "password")
  	@user.save

  	@post = Post.new
  	@post = Post.new(title: "Test Post", body: "test test", user_id: "1")
  	@post.save

  	@comment = Comment.new
    @comment = Comment.new(user_id: "1", post_id: "1", body: "test test test")
  end

  it "tests that our comment entry is valid" do
    expect(@user.valid?).to be true
    expect(@post.valid?).to be true
    expect(@comment.valid?).to be true
  end

  it "comment body cannot be empty" do
    @comment.body = ""
    expect(@comment.valid?).to be false
  end

  it "user_id cannot be empty" do
    @comment.user_id = ""
    expect(@comment.valid?).to be false
  end

  it "user_id should contain a valid user id from the User table" do
    @comment.user_id = "1"
    expect(@comment.valid?).to be true

    @comment.user_id = "2"
    expect(@comment.valid?).to be false
  end

  it "post_id cannot be empty" do
    @comment.post_id = ""
    expect(@comment.valid?).to be false
  end

  it "post_id should contain a valid post_id from the Post table" do
    @comment.post_id = "1"
    expect(@comment.valid?).to be true

    @comment.post_id = "2"
    expect(@comment.valid?).to be false
  end

end


