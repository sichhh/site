RSpec.describe UserMailer, type: :mailer do
  describe "friend_request_email" do
    let(:user) { create :user, email: "user1@example.com" }
    let(:friend) { create :user, email: "friend@example.com" }
    let(:friendship) { create :friendship, user: user, friend: friend }
    let(:friend_request_email) { UserMailer.friend_request_email(friendship).deliver_now }

    it "sends an email to the friend with the correct subject" do
      expect(friend_request_email.to).to eq([friend.email])
      expect(friend_request_email.subject).to eq("Вам поступила заявка в друзья")
    end

    it "sends the email from the correct address" do
      expect(friend_request_email.from).to eq(["sich_site@mail.ru"])
    end
  end
end
