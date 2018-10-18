require "rails_helper"

RSpec.feature "Integration Tests", :type => :feature do
  def login_user(user)
    visit "/login"

    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password

    click_button 'Log In'
  end

  before :each do
    @user = User.new(name: "Test User", email: "user@test.com", password: "password", password_confirmation: "password")
    @user.save

    @user2 = User.new(name: "Test User 2", email: "user2@test.com", password: "password", password_confirmation: "password")
    @user2.save
  end

  scenario "the user should see different titles depending on the page that they \
            are on" do
    #TODO
  end

  scenario "User Navigates the the sign up page and clicks 'create my account' \
            button without filling in any fields" do
    visit "/signup"
    click_on 'Create my account'
    expect(page).to have_text("errors")
  end

  scenario "User Navigates the the sign up page and a confirmation password that \
            does not match the password given" do
    visit "/signup"

    fill_in "Name", :with => "test user"
    fill_in "Email", :with => "test@email.com"
    fill_in "Password", :with => "password"
    fill_in "Confirmation", :with => "wrong_confirmation"

    click_on 'Create my account'
    expect(page).to have_text("Password confirmation doesn't match Password")
  end

  scenario "User Navigates the the sign up page and successfully creates a new account" do
    visit "/signup"

    fill_in "Name", :with => "test user"
    fill_in "Email", :with => "test@email.com"
    fill_in "Password", :with => "password"
    fill_in "Confirmation", :with => "password"

    click_on 'Create my account'
    expect(page).to have_text("Account Created! Welcome to the OTB Academy Blog")
  end

  scenario "User tries an invalid login and the flash appears. they then visit \
            the home page and should not see the flash message" do
    visit "/login"

    click_button 'Log In'

    expect(page).to have_text("Invalid email/password combination")
    visit "/"
    expect(page).to_not have_text("Invalid email/password combination")
  end

  scenario "user with a valid account can log in to the website and is successfully \
            redirected to their profile page" do
    login_user(@user)
    expect(page).to have_text("Test User")
  end

  scenario "user should be presented with a different number of options navigation \
            options after logging in" do
    visit "/"
    expect(page).to_not have_link("Profile")
    expect(page).to_not have_link("Settings")
    expect(page).to_not have_link("Log Out")

    login_user(@user)

    expect(page).to have_link("Profile")
    expect(page).to have_link("Settings")
    expect(page).to have_link("Log Out")

    click_link 'Log Out'

    expect(page).to_not have_link("Profile")
    expect(page).to_not have_link("Settings")
    expect(page).to_not have_link("Log Out")
  end

  scenario "User should be remembered when leaving the site if logged in" do
    login_user(@user)

    expect(page).to have_link("Profile")
    expect(page).to have_link("Settings")
    expect(page).to have_link("Log Out")

    visit "http://www.google.com"

    visit "/"

    expect(page).to have_link("Profile")
    expect(page).to have_link("Settings")
    expect(page).to have_link("Log Out")
  end

  scenario "User should not be remembered after browser close if they have not \
            checked the 'remember me' checkbox when loggin in" do
    login_user(@user)

    page.reset!

    expect(page).to_not have_link("Profile")
    expect(page).to_not have_link("Settings")
    expect(page).to_not have_link("Log Out")
  end

  scenario "User should be remembered after browser close if they have \
            checked the 'remember me' checkbox when loggin in" do
    #TODO
  end

  scenario "user should not be able to update the profile if the form is not \
            filled in correctly. error messages will be displayed to the user \
            detailing the failings" do
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
    expect(page).to have_text("All Users")
  end
end
