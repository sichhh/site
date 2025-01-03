module Friendships
  class Destroy
    class Delete
      include Interactor

      delegate :friendship, to: :context

      def call
        if friendship.pending?
          cancel_request
          context.notice = "Запрос в друзья отменён."
        elsif friendship.status == "friends"
          remove_friendship
          context.notice = "Вы удалили пользователя из друзей."
        else
          context.fail!(errors: { base: ["Невозможно выполнить операцию для текущего статуса: #{friendship.status}"] })
        end
      end

      private

      def cancel_request
        if friendship.destroy
          context.success!
        else
          context.fail!(errors: friendship.errors.full_messages)
        end
      end

      def remove_friendship
        inverse_friendship = Friendship.find_by(user_id: friendship.friend_id, friend_id: friendship.user_id)

        ActiveRecord::Base.transaction do
          friendship.destroy!
          inverse_friendship&.destroy!
          context.success!
        end
      rescue ActiveRecord::RecordInvalid => e
        context.fail!(errors: { base: [e.message] })
      end
    end
  end
end
