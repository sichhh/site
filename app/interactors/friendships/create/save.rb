module Friendships
  class Create
    class Save
      include Interactor

      delegate :current_user, :friend, to: :context

      def call
        existing_friendship = find_existing_friendship

        return create_new_friendship if existing_friendship.blank?

        if rejected_friendship?(existing_friendship)
          reactivate_friendship(existing_friendship)
        elsif existing_friendship.nil?
          create_new_friendship
        else
          fail_friendship_exists
        end
      end

      private

      def find_existing_friendship
        current_user.friendships.find_by(friend: friend)
      end

      def rejected_friendship?(friendship)
        friendship&.rejected?
      end

      def reactivate_friendship(friendship)
        return if friendship.update(status: "pending")

        context.fail!(errors: friendship.errors)
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
