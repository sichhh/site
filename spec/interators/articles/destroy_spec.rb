RSpec.describe Articles::Destroy do
  subject(:call) { described_class.call(id: article_id) }

  let!(:article) { create :article }
  let(:article_id) { article.id }
  let(:nonexistent_article_id) { 99999 }


  describe ".call" do
    context "when article exists" do
      it "destroys the article" do
        expect { call }.to change { Article.count }.by(-1)
      end

      it "succeeds" do
        expect(call).to be_a_success
      end
    end

    context "when article does not exist" do
      let(:article_id) { nonexistent_article_id }

      it "fails the context instead of raising an error" do
        expect(call).to be_a_failure
        expect(call.errors[:base]).to include('Article not found')
      end
    end
  end
end
