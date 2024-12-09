RSpec.describe Articles::Destroy do
  subject(:context) { described_class.call(id: article_id) }

  let!(:article) { create :article }
  let(:article_id) { article.id }
  let(:nonexistent_article_id) { 99999 }


  describe ".call" do
    context "when article exists" do
      it "destroys the article" do
        expect { context }.to change { Article.count }.by(-1)
      end

      it "succeeds" do
        expect(context).to be_a_success
      end
    end

    context "when article does not exist" do
      let(:article_id) { nonexistent_article_id }

      it "fails the context instead of raising an error" do
        expect(context).to be_a_failure
        expect(context.errors[:base]).to include('Article not found')
      end
    end
  end
end
