RSpec.describe FriendshipPolicy do
  let(:friendship) { create :friendship }

  shared_examples "access rights check" do |action, user_context|
    subject { described_class.new(friendship, user: user).apply(action) }

    context "when the user is not involved in the friendship" do
      let(:user) { create(:user) }
      it { is_expected.to eq false }
    end

    context "when the user is the creator of the friendship" do
      let(:user) { friendship.user }
      it { is_expected.to eq true }
    end

    context "when the user is the recipient of the friendship" do
      let(:user) { friendship.friend }
      it { is_expected.to eq true }
    end

    context "when the user is not authenticated" do
      let(:user) { nil }
      it { is_expected.to eq false }
    end
  end

  describe "#index?" do
    subject { described_class.new(nil, user: user).apply(:index?) }

    context "when the user is authenticated" do
      let(:user) { create(:user) }
      it { is_expected.to eq true }
    end

    context "when the user is not authenticated" do
      let(:user) { nil }
      it { is_expected.to eq false }
    end
  end

  describe "#create?" do
    subject { described_class.new(Friendship.new(friend_id: friend_id), user: user).apply(:create?) }

    let(:user) { create(:user) }
    let(:friend_id) { create(:user).id }

    context "when the user tries to send a request to themselves" do
      let(:friend_id) { user.id }
      it { is_expected.to eq false }
    end

    context "when the user sends a request to another user" do
      it { is_expected.to eq true }
    end

    context "when the user is not authenticated" do
      let(:user) { nil }
      it { is_expected.to eq false }
    end
  end

  describe "#update?" do
    it_behaves_like "access rights check", :update?, -> { user }
  end

  describe "#destroy?" do
    it_behaves_like "access rights check", :destroy?, -> { user }
  end
end
