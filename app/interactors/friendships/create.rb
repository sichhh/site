module Friendships
  class Create
    include Interactor::Organizer

    organize Friendships::Create::PrepareParams,
             Friendships::Create::Save
  end
end
