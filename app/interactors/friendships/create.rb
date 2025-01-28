module Friendships
  class Create
    include Interactor::Organizer

    organize Friendships::Create::PrepareParams,
             Friendships::Create::Save

    delegate :friendship, to: :context

    after do
      UserMailer.friend_request_email(friendship).deliver_later

      FriendshipArticleJob.perform_later(:request_sent, friendship.user_id, friendship.friend_id)
    end
  end
end
