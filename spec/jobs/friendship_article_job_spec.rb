RSpec.describe FriendshipArticleJob, type: :job do
  let(:user) { create :user }
  let(:friend) { create :user, first_name: "Иван" }

  describe "#perform" do
    context "when action is :request_sent" do
      it "calls Articles::Create with correct parameters" do
        expect(Articles::Create).to receive(:call).with(
          user: user,
          params: {
            title: "Заявка отправлена",
            body: "Я отправил заявку Иван",
            status: "public"
          }
        )

        described_class.perform_now(:request_sent, user.id, friend.id)
      end
    end

    context "when action is :request_accepted" do
      it "calls Articles::Create with correct parameters" do
        expect(Articles::Create).to receive(:call).with(
          user: user,
          params: {
            title: "Новый друг",
            body: "У меня новый друг Иван",
            status: "public"
          }
        )

        described_class.perform_now(:request_accepted, user.id, friend.id)
      end
    end

    context "when action is invalid" do
      it 'does not call Articles::Create' do
        expect(Articles::Create).not_to receive(:call)

        expect {
          described_class.perform_now(:invalid_action, user.id, friend.id)
        }.not_to raise_error
      end
    end
  end
end
