class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to the Turtle App"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def facebook_login
    @user =  User.from_omniauth(request.env["omniauth.auth"])
    result = @user.save(context: :facebook_login)
      if result
        log_in @user
        redirect_to @user
      else
        redirect_to auth_failure_path
      end
  end
  
  #認証に失敗した際の処理
  def auth_failure 
    @user = User.new
    render 'new'
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_name, :website, :introduction, :phonenumber, :gender,)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
