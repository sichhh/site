module Avatars
  class Upload
    include Interactor::Organizer

    organize Avatars::Upload::UploadFile,
             Avatars::Upload::UploadUrl
  end
end
