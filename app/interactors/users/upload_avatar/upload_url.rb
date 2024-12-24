module Users
  class UploadAvatar
    class UploadUrl
      include Interactor

      delegate :user, :avatar_url, to: :context

      def call
        attach_from_url if avatar_url
      end

      private

      def attach_from_url
        file = open_file(avatar_url)
        user.avatar.attach(io: file, filename: File.basename(URI.parse(avatar_url).path))
      end

      def open_file(url)
        URI.parse(url).open
      end
    end
  end
end
