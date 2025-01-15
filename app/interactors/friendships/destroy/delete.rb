module Friendships
  class Destroy
    class Delete
      include Interactor

      delegate :friendship, to: :context

      def call
        if friendship.pending?
          cancel_request
          context.notice = "Запрос в друзья отменён."
        elsif friendship.accepted?
          remove_friendship
          context.notice = "Вы удалили пользователя из друзей."
        end
      end

      private

      def cancel_request
        friendship.destroy
        context.success!
      end

      def remove_friendship
        ActiveRecord::Base.transaction do
          friendship.destroy!
          context.success!
        end
      rescue ActiveRecord::RecordInvalid => e
        context.fail!(errors: { base: [e.message] })
      end
    end
  end
end
