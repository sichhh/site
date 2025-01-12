module Friendships
  class Update
    include Interactor::Organizer

    organize Friendships::Find,
             Friendships::Status::FriendshipStatusUpdater
  end
end
