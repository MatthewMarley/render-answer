class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      # This was throwing up the following area - uninitialized constant Article::ArticleCategory 
      #(NameError in UsersController#Show). -> changing to root_path fixes
      #redirect_to user_path(user)
      redirect_to root_path
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end