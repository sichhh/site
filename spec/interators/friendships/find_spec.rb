RSpec.describe Friendships::Find, type: :interactor do
  let(:friendship) { create :friendship }
  let(:context) { Interactor::Context.new(id: friendship.id) }

  describe ".call" do
    let(:call) { described_class.call(context) }

    context "when the friendship exists" do
      it "sets the friendship in the context" do
        call
        expect(context.friendship).to eq(friendship)
      end

      it "does not fail" do
        call
        expect(call).to be_success
      end
    end

    context "when the friendship does not exist" do
      before do
        context[:id] = -1
      end

      it "fails the context with an error" do
        call
        expect(call).to be_failure
        expect(call.errors).to eq({ base: ["Friendship not found"] })
      end
    end
  end
end
