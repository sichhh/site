module Comments
  class DestroyRecord
    include Interactor

    delegate :comment, to: :context

    def call
      return if comment.destroy

      context.fail!(errors: comment.errors)
    end
  end
end
