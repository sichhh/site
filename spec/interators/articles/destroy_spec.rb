RSpec.describe Articles::Destroy do
  subject(:context) { described_class.call(id: article.id) }

  let!(:article) { create :article }

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
      let(:article_id) { -1 }

      before do
        allow(Article).to receive(:find_by).and_return(nil)
      end

      it "fails the context instead of raising an error" do
        expect { context }.not_to raise_error
        expect(context).to be_a_failure
        expect(context.errors[:base]).to include('Article not found')
      end
    end
  end
end
