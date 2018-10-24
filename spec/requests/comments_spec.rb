require 'rails_helper'

RSpec.describe "Comments", type: :request do

  before :each do    

  	@user = User.new
  	@user = User.new(id: "1", name: "Test User", email: "user@test.com", password: "password", password_confirmation: "password")
  	@user.save

  	@post = Post.new
  	@post = Post.new(id: "2", title: "Test Post", body: "test test", user_id: "1")
  	@post.save

  	@comment = Comment.new
    @comment = Comment.new(id: "1", user_id: "1", post_id: "1", body: "test test test")
    @comment.save

  end

 describe "GET /posts/:post_id/comments" do
   it "returns status 200 OK" do
     get post_comments_path(2)
     expect(response).to have_http_status(200)
   end
 end

#new_post_comment GET    /posts/:post_id/comments/new
 # describe "GET /posts/:post_id/comments/new" do
 #   it "returns status 200 OK" do
 #     get new_post_comment_path(2,1)
 #     expect(response).to have_http_status(200)
 #   end
 # end

# edit_post_comment GET    /posts/:post_id/comments/:id/edit
#  describe "GET /posts/:post_id/comments/:id/edit" do
#    it "returns status 200 OK" do
#      get edit_post_comment_path(2,1)
#      expect(response).to have_http_status(200)
#    end
#  end

# # post_comment GET    /posts/:post_id/comments/:id
#  describe "GET /posts/:post_id/comments/:id" do
#    it "returns status 200 OK" do
#      get post_comment_path(2,1)
#      expect(response).to have_http_status(200)
#    end
#  end


end
