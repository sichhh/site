module Friendships
  class Create
    include Interactor::Organizer

    organize Friendships::Create::PrepareParams,
             Friendships::Create::Save

    after do
      Rails.logger.info("AFTER HOOK TRIGGERED")
      UserMailer.friend_request_email(context.friendship).deliver_later
    end
  end
end
