module Friendships
  class Destroy
    include Interactor::Organizer

    organize Friendships::Find,
             Friendships::Destroy::Delete
  end
end
