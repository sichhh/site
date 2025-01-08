module Friendships
  module Status
    class FriendshipStatusUpdater
      include Interactor

      delegate :friendship, to: :context

      def call
        if friendship.pending?
          friendship.update(status: "friends")
        else
          context.fail!(errors: { base: friendship.errors.full_messages })
        end
      end
    end
  end
end
