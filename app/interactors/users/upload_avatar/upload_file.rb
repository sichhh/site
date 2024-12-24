module Users
  class UploadAvatar
    class UploadFile
      include Interactor

      delegate :user, :avatar, to: :context

      def call
        attach_file
        validate_avatar
      end

      private

      def attach_file
        user.avatar.attach(avatar)
      end

      def validate_avatar
        return if user.errors[:avatar].blank?

        context.fail!(errors: user.errors.full_messages)
      end
    end
  end
end
