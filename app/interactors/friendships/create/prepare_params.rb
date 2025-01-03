module Friendships
  class Create
    class PrepareParams
      include Interactor

      delegate :friend_id, :current_user, to: :context

      def call
        context.friend = User.find_by(id: friend_id)
        context.fail!(errors: { base: ["Friend not found"] }) if context.friend.nil?
      end
    end
  end
end
