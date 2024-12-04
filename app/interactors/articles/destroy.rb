module Articles
  class Destroy
    include Interactor

    delegate :id, to: :context

    def call
      article = Article.find(id)
      context.fail!(errors: article.errors) unless article.destroy
    end
  end
end
