module Articles
  class Destroy
    include Interactor

    delegate :id, to: :context

    def call
      article = Article.find_by(id: id)

      if article.nil?
        context.fail!(errors: { base: ["Article not found"] })
      elsif !article.destroy
        context.fail!(errors: article.errors)
      end
    end
  end
end
