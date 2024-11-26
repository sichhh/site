class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @articles = ArticlesQuery.new(params).call
  end

  def show
    @article = Article.find(params[:id])
    @comment = @article.comments.build
  end

  def new
    @article = Article.new

    authorize! @article
  end

  def edit
    authorize! @article
  end

  def create
    @article = current_user.articles.build(article_params)
    authorize! @article

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize! @article

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! @article

    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def set_article
    @article = Article.find_by(id: params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
