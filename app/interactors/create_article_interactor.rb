module CreateArticleInteractor
  class Create
    include Interactor

    def call
      article = context.user.articles.build(context.params)

      if article.save
        context.article = article
      else
        context.fail!(errors: article.errors)
      end
    end
  end
end