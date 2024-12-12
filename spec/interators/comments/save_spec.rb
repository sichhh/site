RSpec.describe Comments::Save do
  subject(:call) { described_class.call(comment: comment, comment_params: comment_params) }

  let(:expected_params) { { body: comment_params[:body] } }

  describe ".call" do
    context "when creating a new comment" do
      let(:comment) { build :comment }
      let(:comment_params) { attributes_for :comment }

      it "succeeds and creates a new comment" do
        expect { call }.to change(Comment, :count).by(1)
        expect(call).to be_a_success
      end

      it "saves the comment with correct attributes" do
        call
        expect(Comment.last).to have_attributes(expected_params)
      end

      context "with invalid parameters" do
        let(:comment_params) { attributes_for(:comment, body: nil) }

        it "fails" do
          expect(call).to be_a_failure
        end

        it "provides error messages" do
          call
          expect(call.errors).to eq(call.comment.errors)
        end
      end
    end

    context "when updating an existing comment" do
      let!(:comment) { create :comment, body: "Original Body" }
      let(:comment_params) { { body: "Updated Body" } }

      it "succeeds and updates the comment" do
        call
        expect(comment.reload).to have_attributes(expected_params)
        expect(call).to be_a_success
      end

      context "with invalid parameters" do
        let(:comment_params) { { body: nil } }

        it "fails" do
          expect(call).to be_a_failure
        end

        it "provides error messages" do
          call
          expect(call.errors).to eq(call.comment.errors)
        end
      end
    end
  end
end
