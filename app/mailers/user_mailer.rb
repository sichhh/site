class UserMailer < ApplicationMailer
  default from: "sich_site@mail.ru"

  def friend_request_email(friendship)
    return unless friendship.persisted?

    @user = friendship.user
    @friend = friendship.friend

    mail(to: @friend.email, subject: "Вам поступила заявка в друзья")
  end
end
