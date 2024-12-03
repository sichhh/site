RSpec.describe Articles::Destroy do
  let(:article) { create :article }
  let(:context) { Articles::Destroy.call id: article.id }

  context 'when article exists' do
    it 'destroys the article' do
      expect(context.article).to be_destroyed
    end

    it 'succeeds' do
      expect(context).to be_a_success
    end
  end

  context 'when article does not exist' do
    let(:context) { Articles::Destroy.call id: 999 } 

    it 'fails with a record not found error' do
      expect { context }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end 
