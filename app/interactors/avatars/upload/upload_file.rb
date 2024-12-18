module Avatars
  class Upload
    class UploadFile
      include Interactor

      delegate :user, :avatar, to: :context

      def call
        validate_mime_type
        attach_file if avatar
      end

      private

      def validate_mime_type
        return unless avatar

        acceptable_types = ["image/jpeg", "image/png", "image/jpg"]
        return if acceptable_types.include?(avatar.content_type)

        context.fail!(errors: "Avatar must be a JPEG or PNG or JPG")
      end

      def attach_file
        user.avatar.attach(avatar)
      end
    end
  end
end
