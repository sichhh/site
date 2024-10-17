class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: %i[destroy edit update show]

  def edit; end

  def show; end

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    return unless @comment.save

    redirect_to @article
  end

  def update
    authorize! @comment

    if @comment.update(comment_params)
      redirect_to article_path(@article)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! @comment

    @comment.destroy
    redirect_to article_path(@article), status: :see_other
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
