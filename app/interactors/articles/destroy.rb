module Articles
  class Destroy
    include Interactor

    delegate :id, to: :context

    def call
      article = Article.find_by(id: id)

      return context.fail!(errors: { base: ["Article not found"] }) if article.nil?

      context.fail!(errors: article.errors) unless article.destroy
    end
  end
end
