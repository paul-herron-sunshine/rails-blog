require "rails_helper"

RSpec.feature "Integration Tests", :type => :feature do
  scenario "User visits the home page and then navigates to the about page before visiting the sign up page" do
    visit "/"
    expect(page).to have_title("Home | OTB Academy Blog 2018")
    visit "/about"
    expect(page).to have_title("About | OTB Academy Blog 2018")
    visit "/signup"
    expect(page).to have_title("Sign Up | OTB Academy Blog 2018")
  end

  scenario "User Navigates the the sign up page and clicks 'create my account' button without filling in any fields" do
    visit "/users/new"
    click_on 'Create my account'
    expect(page).to have_text("Name can't be blank")
    expect(page).to have_text("Email can't be blank")
    expect(page).to have_text("Email is invalid")
    expect(page).to have_text("Password can't be blank")
    expect(page).to have_text("Password can't be blank")
    expect(page).to have_text("Password is too short (minimum is 6 characters)")
  end

  scenario "User Navigates the the sign up page and a confirmation password that does not match the password given" do
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
end
