class Admin::ArticlesController < ApplicationController
  before_action :authenticate!

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:success] = "Blog create success!"
      redirect_to [:admin, @article]
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = "Blog update success!"
      redirect_to [:admin, @article]
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    flash[:success] = "Blog delete success!"
    redirect_to admin_articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
