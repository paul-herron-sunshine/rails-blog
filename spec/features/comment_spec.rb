require "rails_helper"

RSpec.feature "Integration Tests Posts", :type => :feature do

  def login_user(user)
    visit login_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button 'Log In'
  end

  def create_post(user, post)
    visit posts_path
    fill_in "Title", :with => post.title
    fill_in "Body", :with => post.body
    fill_in "User_id", :with => user.id
    click_button 'Save Post'
  end

  def create_comment(user, post, comment)
    visit post_comments_path
    fill_in "Body", :with => comment.body
    fill_in "Post_id", :with => comment.post_id
    fill_in "User_id", :with => user.id
    click_button 'Save Post'
  end

  before :each do

    @user_1 = User.create(
      name: "Test User1",
      email: "user1@test.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      last_active_at: Faker::Time.between(365.days.ago, Time.now),
      activated_at: Faker::Time.between(365.days.ago, Time.now)
      )

    @user_2 = User.create(
      name: "Test User2",
      email: "user2@test.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      last_active_at: Faker::Time.between(365.days.ago, Time.now),
      activated_at: Faker::Time.between(365.days.ago, Time.now)
      )

    @post_1 = Post.create(
      title: "Test title",
      body: "Test body",
      user_id: 1,
      votes: 1
      )

    # @post_2 = Post.create(
    #   title: "Test title",
    #   body: "Test body",
    #   user_id: 2,
    #   votes: 1
    #   )

    @comment_1 = Comment.create(
      body: "Test comment body 1",
      post_id: 1,
      user_id: 1
      )

    @comment_2 = Comment.create(
      body: "Test comment body 2",
      post_id: 1,
      user_id: 2
      )

  end

  scenario "user with a valid account can log in to the website and is successfully \
            redirected to their profile page" do
    login_user(@user_1)
    expect(page).to have_text("Test User")
  end

  scenario "User logs in and creates a post" do
    post_count = Post.all.count
    login_user(@user_1)
    visit new_post_path
    fill_in "Title", :with => "Test title"
    fill_in "Body", :with => "Test body"
    click_button 'Save Post'
    expect(Post.all.count).to eq post_count + 1
  end  

  scenario "User logs in and comments on a post" do
    post_count = Comment.all.count
    login_user(@user_1)
    visit new_post_comment_path(@post_1.id)
    # puts page.body
    fill_in "comment[body]", :with => "Test comment body"
    first('input#frm-post-id', visible: false).set(@post_1.id)
    click_button 'Submit Comment'
    expect(Comment.all.count).to eq post_count + 1
  end


  # scenario "User logs in and views a post by another user - should see vote buttons but no delete button" do
  #   login_user(@user_2)
  #   visit post_path(@post)
  #   expect(page).to have_text("👍")
  #   expect(page).to_not have_text("🗑️")
  # end

  # scenario "User logs in and views a post by him/herself - see delete button but no vote buttons" do
  #   login_user(@user_1)
  #   visit post_path(@post)
  #   expect(page).to_not have_text("👍")
  #   expect(page).to have_text("🗑️")
  # end

  # scenario "User is not logged in and views a post - sees 'Log in to vote on this article' link, no buttons" do
  #   visit post_path(@post)
  #   expect(page).to_not have_text("👍")
  #   expect(page).to_not have_text("🗑️")
  #   expect(page).to have_text("Log in to vote on this article")
  # end

  # scenario "User logs in, views article by another user and clicks upvote buttons to raise vote count on article" do
  #   login_user(@user_2)
  #   votes = @post.votes
  #   puts @post.votes
  #   visit post_path(@post)
  #   click_on "👍"
  #   @post.reload
  #   puts @post.votes
  #   expect(@post.votes).to eq votes + 1
  # end

  # scenario "User logs in, views article by another user and clicks downvote buttons to raise vote count on article" do
  #   login_user(@user_2)
  #   votes = @post.votes
  #   puts @post.votes
  #   visit post_path(@post)
  #   click_on "👎"
  #   @post.reload
  #   puts @post.votes
  #   expect(@post.votes).to eq votes - 1
  # end
end
