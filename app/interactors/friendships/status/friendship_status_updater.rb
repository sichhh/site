module Friendships
  module Status
    class FriendshipStatusUpdater
      include Interactor

      delegate :friendship, to: :context

      def call
        return unless friendship.pending?

        friendship.update(status: "accepted")
      end
    end
  end
end
