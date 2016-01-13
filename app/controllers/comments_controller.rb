class CommentsController < ApplicationController
  def create
    @cur_article = Article.find(params[:article_id])
    @comment = @cur_article.comments.build(comment_params)
    if @comment.save
    else
    end
    redirect_to article_path(@cur_article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :email, :content)
  end
end
