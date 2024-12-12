module Comments
  class Destroy
    class FindRecord
      include Interactor

      delegate :id, to: :context

      def call
        comment = Comment.find_by(id: id)

        if comment.nil?
          context.fail!(errors: { base: ["Comment not found"] })
        else
          context.comment = comment
        end
      end
    end
  end
end
