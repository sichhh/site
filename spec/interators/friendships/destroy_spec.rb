RSpec.describe Friendships::Destroy, type: :interactor do
  let(:current_user) { create :user }
  let(:friend) { create :user }
  let!(:friendship) { create(:friendship, user: current_user, friend: friend) }
  let(:context) { { current_user: current_user, id: friendship.id } }

  describe ".call" do
    let(:call) { described_class.call(context) }

    it "organizes the Find and Delete interactors" do
      expect(Friendships::Destroy.organized).to eq([Friendships::Find, Friendships::Destroy::Delete])
    end

    it "successfully destroys a friendship" do
      expect { call }.to change { Friendship.count }.by(-1)
    end
  end
end
