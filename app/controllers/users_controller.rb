class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Render Answer, #{@user.username}! Go to Your Profile to complete your profile"
      redirect_to user_path(@user)
    else
      flash[:danger] = "There was problem creating your account"
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def show
  end
  
  def index
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :first_name, :last_name, :description)
  end
end