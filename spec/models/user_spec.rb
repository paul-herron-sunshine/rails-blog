require 'rails_helper'

RSpec.describe User, type: :model do
  it "should return false for saving a user with no parameters" do
    user = User.new( name: "", email: "", password: "", password_confirmation: "" )
    expect(user.save).to be false
  end
end
