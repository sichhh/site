RSpec.describe Comments::Create, type: :interactor do
  let(:user) { create :user }
  let(:article) { create :article }
  let(:params) { { body: "This is a comment", status: "public"} }

  describe ".call" do
    let(:call) { described_class.call(user: user, article: article, params: params) }

    it "organizes PrepareParams and Save interactors" do
      expect(Comments::Create.organized).to eq([Comments::Create::PrepareParams, Comments::Save])
    end

    it "increases the number of comments by 1" do
      expect { call }.to change { Comment.count }.by(1)
    end
  end
end
