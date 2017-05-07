class UsersController < ApplicationController
  before_action
  
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
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles
  end
  
  def index
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :first_name, :last_name, :description)
  end
end