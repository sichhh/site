module Comments
  class Destroy
    include Interactor::Organizer

    organize Comments::FindRecord,
             Comments::DestroyRecord
  end
end
