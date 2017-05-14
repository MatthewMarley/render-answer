class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_user, except: [:show, :index, :new, :create]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Render Answer, #{@user.username}!"
      redirect_to user_path(@user)

    else
      flash[:danger] = "There was problem creating your account"
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  def show
    @user_articles = @user.articles
  end
  
  def index
    @users = User.all
  end
  
  def friends
    @friendships = current_user.friends
  end
  
  def search
    @users = User.search( params[:search_param])
    if @users
      @users = current_user.except_current_user(@users)
      render partial: "friends/lookup"
    else
      render status: :not_found, nothing: true
    end
  end
  
  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)
    if current_user.save
      redirect_to friends_path, notice: "Friend was successfully added"
    else 
      redirect_to friends_path, notice: "There was an error with adding user as a friend"
    end
  end
    
  private
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to do this."
      redirect_to root_path
    end
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :first_name, :last_name, :description, :avatar)
  end
end