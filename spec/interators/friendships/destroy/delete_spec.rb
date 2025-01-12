RSpec.describe Friendships::Destroy::Delete do
  describe "#call" do
    let(:user) { create :user }
    let(:friend) { create :user }
    let(:context) { { friendship: friendship } }

    subject(:call) { described_class.call(context) }

    context "when the friendship is pending" do
      let(:friendship) { create :friendship, user: user, friend: friend, status: "pending" }

      it "cancels the friend request and sets a success notice" do
        expect(call).to be_success
        expect(call.notice).to eq("Запрос в друзья отменён.")
      end

      context "when the destruction fails" do
        before do
          allow(friendship).to receive :destroy.and_return(false)
          allow(friendship).to receive :errors.and_return(double(full_messages: ["Destroy failed"]))
        end
      end
    end

    context "when the friendship is accepted" do
      let(:friendship) { create :friendship, user: user, friend: friend, status: "accepted" }
      let!(:inverse_friendship) { create :friendship, user: friend, friend: user, status: "accepted" }

      it "removes the friendship and the inverse friendship" do
        expect(call).to be_success
        expect(call.notice).to eq("Вы удалили пользователя из друзей.")
      end
    end
  end
end
