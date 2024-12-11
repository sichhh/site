RSpec.describe Articles::Update, type: :interactor do
  subject(:call) { described_class.call(article: article, article_params: article_params) }
  let(:expected_params) { { title: article_params[:title], body: article_params[:body] } }

  describe ".call" do
    let!(:article) { create :article, title: "Original Title", body: "Original Body" }
    let(:article_params) { { title: "Updated Title", body: "Updated Body" } }

    it "succeeds and updates the article" do
      call
      expect(article.reload).to have_attributes(expected_params)
      expect(call).to be_a_success
    end

    context "with invalid parameters" do
      let(:article_params) { { title: nil } }

      it "fails" do
        expect(call).to be_a_failure
      end

      it "provides error messages" do
        call
        expect(call.errors).to eq(call.article.errors)
      end
    end
  end
  
  describe ".organized" do
    it "organizes the Save interactor" do
      expect(Articles::Update.organized).to eq([Articles::Save])
    end
  end
end
