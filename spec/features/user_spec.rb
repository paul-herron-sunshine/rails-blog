require "rails_helper"

RSpec.feature "Integration Tests", :type => :feature do
  def login_user
    visit "/login"

    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password

    click_button 'Log In'
  end

  before :each do
    @user = User.new(name: "Test User", email: "user@test.com", password: "password", password_confirmation: "password")
    @user.save
  end

  scenario "the user should see different titles depending on the page that they \
            are on" do
    #TODO
  end

  scenario "User Navigates the the sign up page and clicks 'create my account' \
            button without filling in any fields" do
    visit "/signup"
    click_on 'Create my account'
    expect(page).to have_text("Name can't be blank")
    expect(page).to have_text("Email can't be blank")
    expect(page).to have_text("Email is invalid")
    expect(page).to have_text("Password can't be blank")
    expect(page).to have_text("Password can't be blank")
    expect(page).to have_text("Password is too short (minimum is 6 characters)")
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
    login_user
    expect(page).to have_text("Test User")
  end

  scenario "user should be presented with a different number of options navigation \
            options after logging in" do
    visit "/"
    expect(page).to_not have_link("Profile")
    expect(page).to_not have_link("Settings")
    expect(page).to_not have_link("Log Out")

    login_user

    expect(page).to have_link("Profile")
    expect(page).to have_link("Settings")
    expect(page).to have_link("Log Out")

    click_link 'Log Out'

    expect(page).to_not have_link("Profile")
    expect(page).to_not have_link("Settings")
    expect(page).to_not have_link("Log Out")
  end

  scenario "User should be remembered when leaving the site if logged in" do
    login_user

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
    login_user

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
    login_user

    visit edit_user_path(@user.id)

    fill_in "Name", :with => ""
    fill_in "Email", :with => ""
    fill_in "Password", :with => ""
    fill_in "Confirmation", :with => ""


    click_button 'Save changes'

    expect(page).to have_text("errors")

  end
end
