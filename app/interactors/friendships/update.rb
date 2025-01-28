module Friendships
  class Update
    include Interactor::Organizer

    organize Friendships::Find,
             Friendships::Status::FriendshipStatusUpdater

    delegate :friendship, to: :context

    after do
      FriendshipArticleJob.perform_later(:request_accepted, friendship.user_id, friendship.friend_id)
    end
  end
end
