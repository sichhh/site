RSpec.describe Articles::Destroy do
  subject(:context) { described_class.call(id: article.id) }

  let!(:article) { create :article }

  describe '.call' do
    context 'when article exists' do
      it 'destroys the article' do
        expect { context }.to change { Article.count }.by(-1)
      end

      it 'succeeds' do
        expect(context).to be_a_success
      end
    end
  end
end
