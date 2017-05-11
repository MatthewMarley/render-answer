class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

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
      flash[:danger] = "Your article has not been posted!"
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
    @comment = Article.joins(:comment).new
    @comments = Article.joins(:comment).all
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "This article has been removed"
    redirect_to articles_path
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title, :description, :user_id)
  end
  
  def set_article
    @article = Article.find(params[:id])
  end
end