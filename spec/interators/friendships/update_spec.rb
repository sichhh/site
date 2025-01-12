RSpec.describe Friendships::Update, type: :interactor do
  let(:current_user) { create :user }
  let(:friend) { create :user }
  let!(:friendship) { create :friendship, user: current_user, friend: friend, status: "pending" }
  let(:context) { { current_user: current_user, id: friendship.id, status: "accepted" } }

  describe ".call" do
    let(:call) { described_class.call(context) }

    it "organizes Find and FriendshipStatusUpdater interactors" do
      expect(Friendships::Update.organized).to eq([Friendships::Find, Friendships::Status::FriendshipStatusUpdater])
    end

    it "updates the friendship status to accepted" do
      expect { call }.to change { friendship.reload.status }.from("pending").to("accepted")
    end

    it "does not fail the context" do
      call
      expect(call).to be_success
    end
  end
end
