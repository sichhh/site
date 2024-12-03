RSpec.describe Articles::Save do
  let(:user) { create :user }
  let(:params) { attributes_for :article }
  let(:context) { Articles::Save.call user: user, params: params }

  it 'builds a new article for the user' do
    expect { context }.to change { user.articles.count }.by(1)
    expect(context.article).to be_a(Article)
    expect(context.article.user).to eq(user)
  end

  it 'assigns attributes to the article' do
    context
    expect(context.article.title).to eq(params[:title])
    expect(context.article.body).to eq(params[:body])
  end

  context 'when article is valid' do
    it 'saves the article' do
      expect { context }.to change { Article.count }.by(1)
      expect(context.article).to be_persisted
    end

    it 'succeeds' do
      expect(context).to be_a_success
    end
  end

  context 'when article is invalid' do
    let(:params) { attributes_for :article, title: nil }

    it 'does not save the article' do
      expect { context }.not_to change { Article.count }
      expect(context.article).not_to be_persisted
    end

    it 'fails with errors' do
      expect(context).to be_a_failure
      expect(context.errors).to include(:title)
    end
  end
end 
