module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super do |user|
        attach_default_avatar(user) if user.persisted? && !user.avatar.attached?
      end
    end

    private

    def attach_default_avatar(user)
      default_avatar_path = Rails.root.join("app/assets/images/default_avatar.webp")
      user.avatar.attach(io: File.open(default_avatar_path), filename: "default_avatar.webp",
                         content_type: "image/webp")
    end
  end
end
