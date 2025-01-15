RSpec.describe Friendships::Find, type: :interactor do
  let(:friendship) { create :friendship }
  let(:friendship_id) { friendship.id }
  let(:context) { { id: friendship_id } }
  describe ".call" do
    let(:call) { described_class.call(context) }
    context "when the friendship exists" do
      it "sets the friendship in the context" do
        expect(call[:friendship]).to eq(friendship)
      end
      it "does not fail" do
        call
        expect(call).to be_success
      end
    end
    context "when the friendship does not exist" do
      let(:friendship_id) { nil }
      it "fails the context with an error" do
        call
        expect(call).to be_failure
        expect(call.errors).to eq({ base: ["Friendship not found"] })
      end
    end
  end
end
