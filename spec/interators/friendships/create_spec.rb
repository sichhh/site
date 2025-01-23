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

    it "sends a friend request email" do
      expect {
        call
      }.to have_enqueued_mail(UserMailer, :friend_request_email).with(an_instance_of(Friendship))
    end

    context "when the friendship is not created" do
      let(:context) { { current_user: current_user, friend_id: nil } }

      it "does not send a friend request email" do
        expect {
          call
        }.not_to have_enqueued_mail(UserMailer, :friend_request_email)
      end
    end
  end
end
