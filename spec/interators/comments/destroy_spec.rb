RSpec.describe Comments::Destroy do
  subject(:call) { described_class.call(id: comment_id) }

  let!(:comment) { create(:comment) }
  let(:comment_id) { comment.id }
  let(:nonexistent_comment_id) { 99999 }

  describe ".call" do
    context "when comment exists" do
      it "destroys the comment" do
        expect { call }.to change { Comment.count }.by(-1)
      end

      it "succeeds" do
        expect(call).to be_a_success
      end
    end

    context "when comment does not exist" do
      let(:comment_id) { nonexistent_comment_id }

      it "fails the context instead of raising an error" do
        expect(call).to be_a_failure
        expect(call.errors[:base]).to include("Comment not found")
      end
    end
  end
end
