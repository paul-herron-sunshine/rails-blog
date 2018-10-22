class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def index
    @parameters = params
    @users = User.all
    if params[:user] != nil && params[:user].key?(:search_string)
      @users = []
      User.all.each do |u|
        @users << u if u.name.downcase.include?(params[:user][:search_string].downcase)
      end
    end

    @online_users = []
    @offline_users = []
    @users.each do |user|
      if user.activated
        user.is_online ? @online_users << user : @offline_users << user
      end
    end

    if !params.key?("sort_by") || params["sort_by"] == "2"
      @online_users = @online_users.sort {|x, y| y.views <=> x.views}
      @offline_users = @offline_users.sort {|x, y| y.views <=> x.views}
    elsif params["sort_by"] == "3"
      @online_users = @online_users.sort {|x, y| y.last_active_at <=> x.last_active_at}
      @offline_users = @offline_users.sort {|x, y| y.last_active_at <=> x.last_active_at}
    end


    @users = (@online_users + @offline_users).paginate(page: params[:page])

  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    if @user.id != current_user.id
      @user.set_views(@user.views + 1)
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Thank you. We have sent an activation email to #{@user.email}. Please visit the link included to complete your registration"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    if current_user.admin || user.id == current_user.id
      user.destroy
      flash[:success] = "#{user.name}'s account has been successfully deleted"
      redirect_to root_url
    else
      flash[:danger] = "You do not have the authority to delete #{user.name}'s account"
      redirect_to root_url
    end
  end

  private
    def user_params
        params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation,
                                     :search_string)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please Log In."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
