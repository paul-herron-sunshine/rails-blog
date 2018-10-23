require 'rails_helper'

RSpec.describe Comment, type: :model do

  before :each do

  	@user = User.new
  	@user = User.new(name: "Test User", email: "user@test.com", password: "password", password_confirmation: "password")
  	@user.save

  	@post = Post.new
  	@post = Post.new(title: "Test Post", body: "test test", user_id: "1", votes: "1")
  	@post.save
  end

  it "tests that our post entry is valid" do
    expect(@user.valid?).to be true
    expect(@post.valid?).to be true
  end

  it "disallows an empty post body" do
    @post.body = ""
    expect(@post.valid?).to be false
  end

  it "disallows an empty user_id" do
    @post.user_id = ""
    expect(@post.valid?).to be false
  end

  it "ensures that user_id contains a valid user id from the User table" do
    @post.user_id = "1"
    expect(@post.valid?).to be true

    @post.user_id = "2"
    expect(@post.valid?).to be false
  end

  it "disallows an empty title field" do
    @post.title = ""
    expect(@post.valid?).to be false
  end
end
