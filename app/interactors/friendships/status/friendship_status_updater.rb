module Friendships
  module Status
    class FriendshipStatusUpdater
      include Interactor

      delegate :friendship, to: :context

      def call
        if friendship.pending?
          friendship.update(status: "friends")
        else
          context.fail!(errors: { base: ["Cannot update friendship status"] })
        end
      end
    end
  end
end
