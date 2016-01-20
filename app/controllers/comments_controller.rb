class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:archive_id])
    @comment = @article.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment blog success!"
      redirect_to archive_path(@article)
    else
      @comments = @article.comments
      render 'archives/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :email, :content)
  end
end
