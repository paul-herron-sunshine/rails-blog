class ApplicationController < ActionController::Base
  include SessionsHelper

  def get_num_users
    User.all.count
  end
end
