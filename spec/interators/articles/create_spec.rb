RSpec.describe Articles::Create, type: :interactor do
  let(:user) { create :user }
  let(:params) { { title: "My Article", body: "Article content", user_id: user.id, status: "public" } }

  describe ".call" do
    let(:call) { described_class.call(user: user, params: params) }    

    it "organizes Prepare and Save interactors" do
      expect(Articles::Create.organized).to eq([Articles::Create::PrepareParams, Articles::Save])
    end

    it "increases the number of articles by 1" do
      expect { call }.to change { Article.count }.by(1)
    end
  end
end
