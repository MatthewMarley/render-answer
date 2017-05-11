class CommentsController < ApplicationController
  
  before_action :set_comment, only: [:show, :edit, :update]
  
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
      flash[:danger] = "There was a problem posting your comment"
      render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  private
  
  def set_comment
    @comment = Comment.find(params[:comment_id])
  end
    
  def comment_params
    params.require(:comment).permit(:comment, :user_id, :article_id)
  end
end