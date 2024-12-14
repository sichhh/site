class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: %i[destroy edit update show]

  def edit; end

  def show; end

  def create
    create_comment = Comments::Create.call(user: current_user, article: @article, params: comment_params)

    if create_comment.success?
      redirect_to @article, notice: "Комментарий успешно создан."
    else
      render "articles/show", status: :unprocessable_entity
    end
  end

  def update
    authorize! @comment

    update_comment = Comments::Update.call(comment: @comment, comment_params: comment_params)

    if update_comment.success?
      redirect_to article_path(@article), notice: "Комментарий успешно обновлен."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! @comment

    destroy_comment = Comments::Destroy.call(id: @comment[:id])

    if destroy_comment.success?
      redirect_to article_path(@article), status: :see_other, notice: "Комментарий удален."
    else
      redirect_to article_path(@article), alert: "Ошибка при удалении комментария."
    end
  end

  private

  def set_article
    @article = Article.find_by(id: params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end
end
