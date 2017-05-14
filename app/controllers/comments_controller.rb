class CommentsController < ApplicationController
  before_action :require_user
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def new
    @article = Article.find(params[:article_id])
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.article = Article.find(params[:article_id])
    
    if @comment.save
      flash[:success] = "Your comment has been posted"
      redirect_to article_path(@comment.article)
    else
      flash[:danger] = @comment.errors.full_messages.join(", ")
      redirect_to :back
    end
  end
  
  def show
  end
  
  def edit
    @comment.article = Article.find(params[:article_id])
  end
  
  def update
    @article = Article.find(params[:article_id])
    if @comment.update(comment_params)
      flash[:success] = "Your comment has been updated"
      redirect_to article_path(@comment.article)
    else
      flash[:danger] = "There was a problem updating your comment"
      render 'edit'
    end
  end
  
  def destroy
    @comment.destroy
      flash[:danger] = "This comment has been removed"
      redirect_to article_path(@comment.article)
  end
  
  private
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to do this."
      redirect_to root_path
    end
  end
  
  def require_same_user
    if current_user != @comment.user and !current_user.admin?
      flash[:danger] = "You can only edit your own comments"
      redirect_to article_path(@comment.article)
    end
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
    
  def comment_params
    params.require(:comment).permit(:body, :user_id, :article_id)
  end
end