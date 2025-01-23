class FriendshipArticleJob < ApplicationJob
  queue_as :default

  #т ут подскажи как лучше сделать рубокоп на метрикс ругается
  def perform(action, user_id, friend_id)
    user = User.find(user_id)
    friend = User.find(friend_id)

    case action
    when :request_sent
      user.articles.create!(
        title: "Заявка отправлена",
        body: "Я отправил заявку #{friend.first_name}",
        status: "public"
      )
    when :request_accepted
      user.articles.create!(
        title: "Новый друг",
        body: "У меня новый друг #{friend.first_name}",
        status: "public"
      )
    end
  end
end
