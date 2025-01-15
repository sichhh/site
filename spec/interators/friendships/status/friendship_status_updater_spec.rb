RSpec.describe Friendships::Status::FriendshipStatusUpdater do
  describe "#call" do
    let(:friendship) { create :friendship, status: initial_status }
    let(:context) { { friendship: friendship } }

    subject(:call) { described_class.call(context) }

    context "when the friendship is pending" do
      let(:initial_status) { "pending" }

      it "updates the status to accepted" do
        expect { call }.to change { friendship.reload.status }.from("pending").to("accepted")
        expect(call).to be_success
      end
    end

    context "when the friendship is not pending" do
      let(:initial_status) { "accepted" }

      it "does not change the status" do
        expect { call }.not_to change { friendship.reload.status }
        expect(call).to be_success
      end
    end
  end
end
