RSpec.describe Friendships::Create, type: :interactor do
  let(:current_user) { create :user }
  let(:friend) { create :user }
  let(:context) { { current_user: current_user, friend_id: friend.id } }

  describe ".call" do
    let(:call) { described_class.call(context) }

    it "organizes the PrepareParams and Save interactors" do
      expect(Friendships::Create.organized).to eq([Friendships::Create::PrepareParams, Friendships::Create::Save])
    end

    it "successfully creates a friendship" do
      expect { call }.to change { Friendship.count }.by(1)
    end
  end
end
