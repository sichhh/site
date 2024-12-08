RSpec.describe Articles::Create::PrepareParams do
  subject(:context) { described_class.call(user: user, params: params) }

  let(:user) { build :user, id: 1 }
  let(:params) { { title: "My Article", body: "Article content" } }

  describe ".call" do
    it "merges user_id into article_params" do
      expect(context.article_params).to eq(title: "My Article", body: "Article content", user_id: 1)
    end
  end
end
