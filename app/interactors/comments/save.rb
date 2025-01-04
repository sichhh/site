module Comments
  class Save
    include Interactor

    delegate :comment, :comment_params, to: :context

    before do
      context.comment ||= Comment.new
    end

    def call
      comment.assign_attributes(comment_params)

      context.fail!(errors: comment.errors) unless comment.save
    end
  end
end
