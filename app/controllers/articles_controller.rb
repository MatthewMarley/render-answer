class ArticlesController < ApplicationController
  before_action :require_user, except: [:show, :index]
  before_action :set_article, only: [:edit, :update, :show, :destroy, :upvote, :downvote]
  before_action :require_same_user, only: [:edit, :update, :destroy]


  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params) 
    @article.user = current_user
    if @article.save
      flash[:success] = "Your article has been posted!"
      redirect_to article_path(@article)
    else
      flash[:danger] = @article.errors.full_messages.join(", ")
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = "Your article has been updated!"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def index
    @articles = Article.all
  end
  
  def show
    @article_comments = @article.comments.paginate(page: params[:page], per_page: 5)
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "This article has been removed"
    redirect_to articles_path
  end
  
  def upvote
    @article.upvote_by current_user
    redirect_to article_path(@article)
  end
  
  def downvote
    @article.downvote_by current_user
    redirect_to article_path(@article)
  end
  
  private
  
  def require_same_user
    if current_user != @article.user and !current_user.admin?
      flash[:danger] = "You can only edit your own articles"
      redirect_to articles_path
    end
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to do this."
      redirect_to root_path
    end
  end
  
  def article_params
    params.require(:article).permit(:title, :description, :user_id)
  end
  
  def set_article
    @article = Article.find(params[:id])
  end
end