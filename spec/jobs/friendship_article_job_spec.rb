RSpec.describe FriendshipArticleJob, type: :job do
  let(:user) { create :user }
  let(:friend) { create :user, first_name: "Иван" }
  let(:action) { nil }

  subject(:perform_job) { described_class.perform_now(action, user.id, friend.id) }

  describe "#perform" do
    context "when action is :request_sent" do
      let(:action) { :request_sent }

      it "calls Articles::Create with correct parameters" do
        expect(Articles::Create).to receive(:call).with(
          user: user,
          params: {
            title: "Заявка отправлена",
            body: "Я отправил заявку Иван",
            status: "public"
          }
        )

        perform_job
      end
    end

    context "when action is :request_accepted" do
      let(:action) { :request_accepted }

      it "calls Articles::Create with correct parameters" do
        expect(Articles::Create).to receive(:call).with(
          user: user,
          params: {
            title: "Новый друг",
            body: "У меня новый друг Иван",
            status: "public"
          }
        )

        perform_job
      end
    end

    context "when action is invalid" do
      let(:action) { :invalid_action }

      it "does not call Articles::Create" do
        expect(Articles::Create).not_to receive(:call)

        expect { perform_job }.not_to raise_error
      end
    end
  end
end
