module Articles
  class Update
    include Interactor::Organizer

    organize Articles::Save
  end
end
