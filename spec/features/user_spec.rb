require "rails_helper"

RSpec.feature "Integration Tests", :type => :feature do
  def login_user(user)
    visit login_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button 'Log In'
  end

  before :each do
    @un_activated_user = User.create(name: "Test User Inactive",
                                     email: "userinactive@test.com",
                                     password: "password",
                                     password_confirmation: "password",
                                     activated: false)
    @user = User.create(name: "Test User",
                        email: "user@test.com",
                        password: "password",
                        password_confirmation: "password",
                        activated: true,
                        last_active_at: Faker::Time.between(365.days.ago, Time.now),
                        activated_at: Faker::Time.between(365.days.ago, Time.now))
    @user2 = User.create(name: "Test User 2",
                         email: "user2@test.com",
                         password: "password",
                         password_confirmation: "password",
                         activated: true,
                         last_active_at: Faker::Time.between(365.days.ago, Time.now),
                         activated_at: Faker::Time.between(365.days.ago, Time.now))
    @user_admin = User.create(name: "Test User Admin",
                              email: "useradmin@test.com",
                              password: "password",
                              password_confirmation: "password",
                              activated: true,
                              admin: true,
                              last_active_at: Faker::Time.between(365.days.ago, Time.now),
                              activated_at: Faker::Time.between(365.days.ago, Time.now))
  end

  scenario "User Navigates the the sign up page and clicks 'create my account' \
            button without filling in any fields. will receive notification of \
            errors in the form" do
    visit signup_path
    click_on 'Create my account'
    expect(page).to have_text("errors")
  end

  scenario "User Navigates the the sign up page and a confirmation password that \
            does not match the password given. should receive notification \
            of the error" do
    visit signup_path

    fill_in "Name", :with => "test user"
    fill_in "Email", :with => "test@email.com"
    fill_in "Password", :with => "password"
    fill_in "Confirmation", :with => "wrong_confirmation"

    click_on 'Create my account'
    expect(page).to have_text("Password confirmation doesn't match Password")
  end

  scenario "User Navigates the the sign up page and successfully creates a new account" do
    visit signup_path

    fill_in "Name", :with => "test user"
    fill_in "Email", :with => "test@email.com"
    fill_in "Password", :with => "password"
    fill_in "Confirmation", :with => "password"

    click_on 'Create my account'
    expect(page).to have_text("Thank you. We have sent an activation email to test@email.com")
  end

  scenario "User tries an invalid login and the flash appears. they then visit \
            the home page and should not see the flash message" do
    visit login_path

    click_button 'Log In'

    expect(page).to have_text("Invalid email/password combination")
    visit root_path
    expect(page).to_not have_text("Invalid email/password combination")
  end

  scenario "user with a valid account can log in to the website and is successfully \
            redirected to their profile page" do
    login_user(@user)
    expect(page).to have_text("Test User")
  end

  scenario "user should be presented with a different number of options navigation \
            options after logging in" do
    visit root_path
    expect(page).to_not have_link("Profile")
    expect(page).to_not have_link("Settings")
    expect(page).to_not have_link("Log out")

    login_user(@user)

    expect(page).to have_link("Profile")
    expect(page).to have_link("Settings")
    expect(page).to have_link("Log out")

    click_link 'Log out'

    expect(page).to_not have_link("Profile")
    expect(page).to_not have_link("Settings")
    expect(page).to_not have_link("Log out")
  end

  scenario "User should be remembered when leaving the site if logged in" do
    login_user(@user)

    expect(page).to have_link("Profile")
    expect(page).to have_link("Settings")
    expect(page).to have_link("Log out")

    visit "http://www.google.com"

    visit root_path

    expect(page).to have_link("Profile")
    expect(page).to have_link("Settings")
    expect(page).to have_link("Log out")
  end

  scenario "User should not be remembered after browser close if they have not \
            checked the 'remember me' checkbox when loggin in" do
    #TODO Gav said no!
  end

  scenario "User should be remembered after browser close if they have \
            checked the 'remember me' checkbox when loggin in" do
    #TODO Gav said no!
  end

  scenario "User should not be able to update the profile if the form is not \
            filled in correctly. error messages will be displayed to the user \
            detailing the errors in the form" do
    login_user(@user)

    visit edit_user_path(@user.id)

    fill_in "Name", :with => ""
    fill_in "Email", :with => ""
    fill_in "Password", :with => ""
    fill_in "Confirmation", :with => ""


    click_button 'Save changes'

    expect(page).to have_text("errors")

  end

  scenario "user should be able to update their profile if all values entered are \
            valid" do
    login_user(@user)

    visit edit_user_path(@user.id)

    fill_in "Name", :with => "New Name"
    fill_in "Email", :with => "new@email.com"
    fill_in "Password", :with => "newpassword"
    fill_in "Confirmation", :with => "newpassword"


    click_button 'Save changes'

    expect(page).to have_text("Profile Updated")
  end

  scenario "user who is not logged in should not be able to access edit profile \
            page" do
    visit edit_user_path(@user.id)
    expect(page).to_not have_button("Save changes")
  end

  scenario "A logged in user should only be able to access his own edit profile \
            page" do
    login_user(@user)
    visit edit_user_path(@user2.id)
    expect(page).to_not have_button("Save changes")
  end

  scenario "un logged in users should not be able to view full profile pages\
            of other users" do
    visit user_path(@user.id)
    expect(page).to_not have_text(@user.name)
  end

  scenario "Logged in users be able to view full profile pages\
            of other users" do
    login_user(@user)
    visit user_path(@user2.id)
    expect(page).to have_text(@user2.name)
  end

  scenario "All users (both logged in and not logged in) will be able to see a \
            list of all users on the site" do
    visit users_path
    expect(page).to have_text("Our Bloggers")
  end

  scenario "Admins should be able to delete other users" do
    login_user(@user_admin)
    visit users_path
    users_before_delete = User.all.count
    click_link("delete", :match => :first)
    expect(User.all.count).to_not eq users_before_delete
  end

  scenario "Any user should be able to delete their own account" do
    login_user(@user)
    visit user_path(@user)
    users_before_delete = User.all.count
    click_link("emove Account")
    expect(User.all.count).to_not eq users_before_delete
  end

  scenario "A non admin user should not be able to delete another persons account" do
    login_user(@user)
    visit user_path(@user2)
    expect(page).to_not have_text "Delete Account"
  end

  scenario "Should redirect the user to the home page with a message if they \
            have not activated their account upon login" do
    @un_activated_user.save
    login_user(@un_activated_user)
    expect(page).to have_text("Account not activated. Check your email for the activation link.")
  end

  scenario "search functionality on the users page displays only users containing the search string" do
    visit users_path
    expect(page).to have_text "Test User"
    expect(page).to have_text "Test User 2"
    expect(page).to have_text "Test User Admin"

    fill_in "user_search_string", :with => "Test User 2"
    click_button "Search"

    expect(page).to have_text "Test User 2"
    expect(page).to_not have_text "Test User Admin"
  end

  scenario "views should be incemented when another user visits a profile" do
    login_user(@user)
    views_before_profile_view = @user2.views
    visit "/users/#{@user2.id}"
    @user2.reload
    expect(@user2.views).to_not eq views_before_profile_view
  end

  scenario "views should be incemented when another user visits a profile" do
    login_user(@user2)
    views_before_profile_view = @user2.views
    visit "/users/#{@user2.id}"
    @user2.reload
    expect(@user2.views).to eq views_before_profile_view
  end

  scenario "is_online flag should be true when user is logged in" do
    expect(@user_admin.is_online).to be false
    login_user(@user_admin)
    @user_admin.reload
    expect(@user_admin.is_online).to be true
  end

  scenario "a non logged in user should not be able to view an inbox" do
    visit user_inbox_path
    expect(page).to have_text "Log In"
  end

  scenario "a logged in user should be able to view the inbox" do
    login_user(@user)
    visit user_inbox_path
    expect(page).to_not have_text "Log In"
  end

  scenario "a non logged in user should not be able to view any messages" do
    visit messages_path
    expect(page).to have_text "Log In"
  end

  scenario "a logged in user should be able to view the inbox" do
    login_user(@user)
    visit messages_path
    expect(page).to_not have_text "Log In"
  end

  scenario "a logged in user should be able to send a message to another user" do
    initial_msg_count = Message.all.count

    login_user(@user)
    visit user_path(@user2.id)
    click_on "Start Conversation"
    fill_in "message", :with => "test message content"
    click_button "Send Message"

    expect(Message.all.count).to be > initial_msg_count
  end
end
