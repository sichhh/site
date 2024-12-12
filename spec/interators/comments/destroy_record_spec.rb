RSpec.describe Comments::DestroyRecord do
  subject(:context) { described_class.call(comment: comment) }

  let!(:comment) { create(:comment) }

  describe ".call" do
    context "when the comment is successfully destroyed" do
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "removes the comment from the database" do
        expect { context }.to change { Comment.exists?(comment.id) }.from(true).to(false)
      end
    end

    context "when the comment cannot be destroyed" do
      before do
        allow(comment).to receive(:destroy).and_return(false)
        allow(comment).to receive_message_chain(:errors, :full_messages).and_return(["Cannot destroy comment"])
      end

      it "fails the context" do
        expect(context).to be_a_failure
      end
    end
  end
end
