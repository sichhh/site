class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @articles = ArticlesQuery.new(params).call
  end

  def show
    @article = Article.find(params[:id])
    @comment = @article.comments.build
    @comments = CommentsQuery.new(@article.comments, params).call
  end

  def new
    @article = current_user.articles.build

    authorize! @article
  end

  def edit
    authorize! @article
  end

  def create
    create_article = Articles::Create.call(user: current_user, params: article_params)

    if create_article.success?
      redirect_to create_article.article, notice: "Статья успешно создана."
    else
      @article = create_article.article
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize! @article

    update_article = Articles::Update.call(article: @article, article_params: article_params)

    if update_article.success?
      redirect_to update_article.article
    else
      @article = update_article.article
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! @article

    destroy_article = Articles::Destroy.call(id: params[:id])

    if destroy_article.success?
      redirect_to root_path, status: :see_other
    else
      redirect_to root_path
    end
  end

  private

  def set_article
    @article = Article.find_by(id: params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
