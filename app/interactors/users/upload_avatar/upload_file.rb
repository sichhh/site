module Users
  class UploadAvatar
    class UploadFile
      include Interactor

      delegate :user, :avatar, to: :context

      def call
        return if avatar.blank?

        return if user.avatar.attach(avatar)

        context.fail!(errors: user.errors.full_messages)
      end
    end
  end
end
