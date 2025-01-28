class FriendshipArticleJob < ApplicationJob
  queue_as :default

  def perform(action, user_id, friend_id)
    user = User.find(user_id)
    friend = User.find(friend_id)

    case action
    when :request_sent
      create_article(user, "Заявка отправлена", "Я отправил заявку #{friend.first_name}")
    when :request_accepted
      create_article(user, "Новый друг", "У меня новый друг #{friend.first_name}")
    end
  end

  private

  def create_article(user, title, body)
    Articles::Create.call(
      user: user,
      params: {
        title: title,
        body: body,
        status: "public"
      }
    )
  end
end
