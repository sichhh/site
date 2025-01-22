module Friendships
  class Create
    include Interactor::Organizer

    organize Friendships::Create::PrepareParams,
             Friendships::Create::Save

    delegate :friendship, to: :context

    after do
      UserMailer.friend_request_email(friendship).deliver_later
    end
  end
end
