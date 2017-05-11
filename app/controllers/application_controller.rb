class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :require_admin

  def current_user
    # If current_user is undefined, then assign it the following value. Otherwise leave it alone
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
    
  def logged_in?
    # Double bang operator. a single ! returns the opposite boolean value of the operand
    # !! converts value to a boolean. In this case, if current_user exists, return true. Else return false.
    !!current_user
  end
  
  def require_user
    # If logged_in? is false (as current_user does not exist (as a user session has not been started))
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
  
  def require_admin
    # If the user is an admin, current_user.admin returns true.
    # Therefore, !current_user.admin? returns false (the opposite)
    # What if user is not logged in? Can they access this as it uses an "and" operator?
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only admin users can perform that action"
      redirect_to root_path
    end
  end
end
