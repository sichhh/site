module Users
  class UploadAvatar
    include Interactor::Organizer

    organize Users::UploadAvatar::UploadFile,
             Users::UploadAvatar::UploadUrl
  end
end
