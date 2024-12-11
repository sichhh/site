module Comments
  class Destroy
    include Interactor

    delegate :id, to: :context

    def call
      comment = Comment.find_by(id: id)

      return context.fail!(errors: { base: ["Comment not found"] }) if comment.nil?

      context.fail!(errors: comment.errors) unless comment.destroy
    end
  end
end
