module Articles
  class Create
    include Interactor::Organizer

    organize Prepare,
             Save
  end
end
