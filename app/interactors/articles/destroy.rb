module Articles
  class Destroy
    include Interactor

    delegate :id, to: :context

    def call
      article = Article.find_by(id: id)
      return unless article

        context.fail!(errors: article.errors) unless article.destroy
    end
  end
end
