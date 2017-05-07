module UsersHelper
  def user_trophy_icon
    if @user_articles.count >= 25
      "gold_trophy.png"
    elsif @user_articles.count >= 10
      "silver_trophy.png"
    elsif @user_articles.count >= 0
      "bronze_trophy.png"
    end
  end
end