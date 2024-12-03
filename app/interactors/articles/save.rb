module Articles
  class Save
    include Interactor

    delegate :article, :params, to: :context

    before do
      context.article ||= context.user.articles.build
    end

    def call
      article.assign_attributes(params)

      context.fail!(errors: article.errors) unless article.save
    end
  end
end
