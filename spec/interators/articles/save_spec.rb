RSpec.describe Articles::Save do
  subject(:call) { described_class.call(article: article, article_params: article_params) }
  let(:expected_params) { { title: article_params[:title], body: article_params[:body]} }

  describe ".call" do
    context "when creating a new article" do
      let(:article) { build :article }
      let(:article_params) { attributes_for :article }

      it "succeeds and creates a new article" do
        expect { call }.to change(Article, :count).by(1)
        expect(call).to be_a_success
      end

      it "saves the article with correct attributes" do
        call
        expect(article.reload).to have_attributes(expected_params)
      end

      context "with invalid parameters" do
        let(:article_params) { attributes_for(:article, title: nil) }

        it "fails" do
          expect(call).to be_a_failure
        end

        it "provides error messages" do
          call
          expect(call.errors).to eq(call.article.errors)
        end
      end
    end


    context "when updating an existing article" do
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
  end
end
