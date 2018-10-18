require 'rails_helper'

RSpec.describe Comment, type: :model do

  before :each do    

  	@user = Comment.new
  	@user = User.new(name: "Test User", email: "user@test.com", password: "password", password_confirmation: "password")
  	@user.save

  	@post = Comment.new
  	@post = Post.new(title: "Test Post", body: "test test")
  	@post.save

  	@comment = Comment.new
    @comment = Comment.new(user_id: "1", post_id: "1", body: "test test test")
  	@comment.save
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


