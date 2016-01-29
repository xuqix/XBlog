class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:archive_id])
    @comment = @article.comments.build(comment_params)
    if @comment.save
      flash[:success] = "评论成功!"
      redirect_to archive_path(@article)
    else
      @comments = @article.comments
      flash.now[:warning] = "评论失败!"
      render 'archives/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :email, :content)
  end
end
