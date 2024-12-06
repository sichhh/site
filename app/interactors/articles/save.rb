module Articles
  class Save
    include Interactor

    delegate :article, :article_params, to: :context

    before do
      context.article ||= Article.new
    end

    def call
      article.assign_attributes(article_params)

      context.fail!(errors: article.errors) unless article.save
    end
  end
end
