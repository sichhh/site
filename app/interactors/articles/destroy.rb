module Articles
  class Destroy
    include Interactor

    delegate :id, to: :context

    def call
      context.article = Article.find(id)

      context.fail!(errors: context.article.errors) unless context.article.destroy
    end
  end
end
