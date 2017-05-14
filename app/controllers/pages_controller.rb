class PagesController < ApplicationController
  
  def home
    if logged_in?
      @articles = current_user.related_articles.sort_by{|t| t.created_at}.reverse!
    end
    @users = User.all
  end

  def about
  
  end
end