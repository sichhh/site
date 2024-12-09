module Articles
  class Create
    class PrepareParams
      include Interactor
      delegate :user, :params, to: :context

      def call
        context.article_params = params.merge(user_id: user.id)
      end
    end
  end
end
