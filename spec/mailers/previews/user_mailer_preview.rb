# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def friend_request_email
    friendship = FactoryBot.build(:friendship)
    UserMailer.friend_request_email(friendship)
  end
end
