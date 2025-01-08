module Friendships
  class Create
    class Save
      include Interactor

      delegate :current_user, :friend, to: :context

      def call
        return create_new_friendship if existing_friendship.blank?

        if rejected_friendship?
          reactivate_friendship
        else
          fail_friendship_exists
        end
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
        context.fail!(errors: friendship.errors) unless friendship.save
      end

      def fail_friendship_exists
        context.fail!(errors: { base: ["Friendship already exists"] })
      end
    end
  end
end
