RSpec.describe Articles::Create, type: :interactor do
  let(:user) { create :user }
  let(:params) { { title: "My Article", body: "Article content", user_id: user.id, status: "public" } }

  describe ".call" do
    it "organizes Prepare and Save interactors" do
      expect(Articles::Create.organized).to eq([Articles::Create::PrepareParams, Articles::Save])
    end

    it "calls the interactors" do
      expect(Articles::Create::PrepareParams).to receive(:call!).ordered
      expect(Articles::Save).to receive(:call!).ordered
      described_class.call(user: user, params: params)
    end

    it "increases the number of articles by 1" do
      expect { described_class.call(user: user, params: params) }.to change { Article.count }.by(1)
    end
  end
end
