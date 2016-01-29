class ArchivesController < ApplicationController
  def index
    @articles = Article.paginate(page: params[:page], per_page: 10)
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments
  end
end
