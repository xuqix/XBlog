class Admin::CommentsController < ApplicationController
  before_action :authenticate!

  def create
    @cur_article = Article.find(params[:article_id])
    @comment = @cur_article.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment blog success!"
    else
    end
    redirect_to admin_article_path(@cur_article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    flash[:success] = "Delete comment success!"
    @comment.destroy
    redirect_to admin_article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :email, :content)
  end
end
