RSpec.describe Friendships::Create::PrepareParams do
  describe "#call" do
    let(:current_user) { create :user }
    let(:friend) { create :user }
    let(:friend_id) { friend.id }
    let(:context) { { current_user: current_user, friend_id: friend_id } }

    subject(:call) { described_class.call(context) }

    context "when the friend exists" do
      it "sets the friend in the context" do
        expect(call).to be_success
        expect(call.friend).to eq(friend)
      end
    end

    context "when the friend does not exist" do
      let(:friend_id) { -1 }

      it "fails the context with an error" do
        expect(call).to be_failure
        expect(call.errors).to eq({ base: ["Friend not found"] })
      end
    end
  end
end
