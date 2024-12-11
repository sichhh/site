module Comments
  class Create
    class PrepareParams
      include Interactor

      delegate :user, :article, :params, to: :context

      def call
        context.comment_params = params.merge(user_id: user.id, article_id: article.id)
      end
    end
  end
end
