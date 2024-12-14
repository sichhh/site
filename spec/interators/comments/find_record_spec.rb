RSpec.describe Comments::FindRecord do
  subject(:context) { described_class.call(id: comment_id) }

  let!(:comment) { create(:comment) }
  let(:comment_id) { comment.id }
  let(:nonexistent_comment_id) { 99999 }

  describe ".call" do
    context "when the comment exists" do
      it "finds the comment and assigns it to the context" do
        expect(context).to be_a_success
        expect(context.comment).to eq(comment)
      end
    end

    context "when the comment does not exist" do
      let(:comment_id) { nonexistent_comment_id }

      it "fails the context with an appropriate error message" do
        expect(context).to be_a_failure
        expect(context.errors[:base]).to include("Comment not found")
      end
    end
  end
end
