RSpec.describe Comments::Update, type: :interactor do
  subject(:call) { described_class.call(comment: comment, comment_params: comment_params) }

  let(:expected_params) { { body: comment_params[:body] } }

  describe ".call" do
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
  
  describe ".organized" do
    it "organizes the Save interactor" do
      expect(Comments::Update.organized).to eq([Comments::Save])
    end
  end
end
