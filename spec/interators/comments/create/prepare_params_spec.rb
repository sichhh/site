RSpec.describe Comments::Create::PrepareParams do
  subject(:call) { described_class.call(user: user, article: article, params: params) }

  let(:user) { build :user }
  let(:article) { build :article }
  let(:params) { { body: "This is a comment" } }

  describe ".call" do
    it "merges user_id and article_id into comment_params" do
      expect(call.comment_params).to eq(
        body: "This is a comment",
        user_id: user.id,
        article_id: article.id
      )
    end
  end
end
