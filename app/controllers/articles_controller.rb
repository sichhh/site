class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    authorize_action!
  end

  def create
    @article = current_user.articles.build(article_params) # Привязываем статью к текущему пользователю

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize_action! # Проверяем права на обновление

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize_action! # Проверяем права на удаление

    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def set_article
    @article = Article.find_by(id: params[:id])
    return if @article

    redirect_to articles_path
  end

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end

  def authorize_action!
    action = "#{action_name}?" # Получаем имя действия
    policy = ArticlePolicy.new(current_user, @article) # Создаем экземпляр политики

    return if policy.public_send(action)  # Проверяем, есть ли доступ

    raise ActionPolicy::Unauthorized
  end
end
