module Friendships
  class Create
    class Save
      include Interactor

      delegate :current_user, :friend, to: :context

      def call
        return create_new_friendship if existing_friendship.blank?

        reactivate_friendship if rejected_friendship?
      end

      private

      def existing_friendship
        @existing_friendship ||= current_user.friendships.find_by(friend: friend)
      end

      def rejected_friendship?
        existing_friendship&.rejected?
      end

      def reactivate_friendship
        return if existing_friendship.update(status: "pending")

        context.fail!(errors: existing_friendship.errors)
      end

      def create_new_friendship
        friendship = current_user.friendships.build(friend: friend, status: "pending")
        if friendship.save
          context.friendship = friendship
        else
          context.fail!(errors: friendship.errors)
        end
      end
    end
  end
end
