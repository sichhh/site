RSpec.describe Friendships::Create::Save do
  describe "#call" do
    let(:current_user) { create :user }
    let(:friend) { create :user }
    let(:context) { { current_user: current_user, friend: friend } }

    subject(:call) { described_class.call(context) }

    context "when there is no existing friendship" do
      it "creates a new friendship with pending status" do
        expect { call }.to change { current_user.friendships.count }.by(1)
        expect(call).to be_success
        expect(current_user.friendships.last.status).to eq("pending")
      end
    end

    context "when a rejected friendship exists" do
      let!(:existing_friendship) { create :friendship, user: current_user, friend: friend, status: "rejected" }

      it "reactivates the friendship with pending status" do
        expect { call }.not_to change { current_user.friendships.count }
        expect(call).to be_success
        expect(existing_friendship.reload.status).to eq("pending")
      end
    end
  end
end
