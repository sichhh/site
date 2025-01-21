module Friendships
  class Create
    include Interactor::Organizer

    organize Friendships::Create::PrepareParams,
             Friendships::Create::Save

    after do
      UserMailer.friend_request_email(context.friendship).deliver_later
    end
  end
end
