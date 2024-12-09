RSpec.describe Articles::Save do
  subject(:context) { described_class.call(article: article, article_params: article_params) }

  let(:article) { build :article }

  describe ".call" do
    context "when article is valid" do
      let(:article_params) { attributes_for :article }

      it "succeeds" do
        expect(context).to be_a_success
      end

      it "assigns attributes to the article" do
        expect(article).to receive(:assign_attributes).with(article_params)
        context
      end

      it "saves the article" do
        expect(article).to receive(:save).and_return(true)
        context
      end
    end

    context "when article is invalid" do
      let(:article_params) { attributes_for(:article, title: nil) }

      it "fails" do
        expect(context).to be_a_failure
      end

      it "provides error messages" do
        expect(context.errors).to eq(context.article.errors)
      end
    end
  end
end
