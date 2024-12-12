module Comments
  class Destroy
    include Interactor::Organizer

    organize Comments::Destroy::FindRecord,
             Comments::Destroy::DestroyRecord
  end
end
