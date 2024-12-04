RSpec.describe Articles::Save do
  subject(:context) { described_class.call(article: article, article_params: article_params) }

  let(:article) { build :article }
  let(:article_params) { attributes_for(:article) }

  describe '.call' do
    context 'when article is valid' do
      before do
        allow(article).to receive(:save).and_return(true)
      end

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'assigns attributes to the article' do
        expect(article).to receive(:assign_attributes).with(article_params)
        context
      end
    end

    context 'when article is invalid' do
      before do
        allow(article).to receive(:save).and_return(false)
      end

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides error messages' do
        expect(context.errors).to eq(context.article.errors)
      end
    end
  end
end
