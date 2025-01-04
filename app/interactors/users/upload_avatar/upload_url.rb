module Users
  class UploadAvatar
    class UploadUrl
      include Interactor

      delegate :user, :avatar_url, to: :context

      def call
        return if avatar_url.blank?

        file = open_file(avatar_url)

        return if user.avatar.attach(io: file, filename: File.basename(URI.parse(avatar_url).path))

        context.fail!(errors: user.errors.full_messages)
      end

      private

      def open_file(url)
        URI.parse(url).open
      end
    end
  end
end
