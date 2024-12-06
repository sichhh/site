module Articles
  class Create
    include Interactor::Organizer

    organize Articles::Create::PrepareParams,
             Articles::Save
  end
end
