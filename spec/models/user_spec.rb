require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(name: "Test User", email: "user@test.com", password: "password", password_confirmation: "password")
  end

  it "tests that our test user is valid to begin with" do
    expect(@user.valid?).to be true
  end

  it "user name can not just be white space" do
    @user.name = "     "
    expect(@user.valid?).to be false
  end

  it "user name can not be empty" do
    @user.name = ""
    expect(@user.valid?).to be false
  end

  it "user name can not be more than 50 characters" do
    @user.name = "p" * 51
    expect(@user.valid?).to be false
  end

  it "user email can not just be white space" do
    @user.email = "     "
    expect(@user.valid?).to be false
  end

  it "user email must be present" do
    @user.email = ""
    expect(@user.valid?).to be false
  end

  it "user email has to conform to correct format" do
    @user.email = "testemailincorrect@"
    expect(@user.valid?).to be false
    @user.email = ".testemailincorrect.com"
    expect(@user.valid?).to be false
  end

  it "user email has to conform to correct format" do
    @user.email = "testemailincorrect@"
    expect(@user.valid?).to be false
  end

  it "user email has to be longer than 255 characters" do
    @user.email = "email@test.com" * 1000
    expect(@user.valid?).to be false
  end

  it "duplicate users are not valid" do
    dup_user = @user.dup
    @user.save
    expect(dup_user.valid?).to be false
  end

  it "should save all emails as downcase regardless of user input" do
    @user.email = "uSeR@tEst.CoM"
    @user.save
    expect(@user.reload.email).to eq "user@test.com"
  end

  it "tests that the password should be present" do
    @user.password = "        "
    @user.password_confirmation = "        "
    expect(@user.valid?).to be false
  end

  it "tests that the password should be at least 6 characters" do
    @user.password = "p" * 5
    @user.password_confirmation = "p" * 5
    expect(@user.valid?).to be false
  end

  it "tests that the password and confirmation should be the same" do
    @user.password = "password"
    @user.password_confirmation = "sassword"
    expect(@user.valid?).to be false
  end

  it "tests that we can save a user to the database if valid" do
    expect(User.all.count).to be 0
    @user.save
    expect(User.all.count).to be 1
  end

  it "tests that we cant save a user to the database if invalid" do
    expect(User.all.count).to be 0
    @user.name = ""
    @user.save
    expect(User.all.count).to be 0
  end

  it "should return false for a non authenticated user" do
    expect(@user.authenticated?(:remember, '')).to be false
  end

end
