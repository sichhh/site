module Comments
  class FindRecord
    include Interactor

    delegate :id, to: :context

    def call
      comment = Comment.find_by(id: id)

      context.fail!(errors: { base: ["Comment not found"] }) if comment.blank?
      context.comment = comment
    end
  end
end
