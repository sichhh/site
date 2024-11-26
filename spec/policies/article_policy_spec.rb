RSpec.describe ArticlePolicy do
  let(:article) { create :article }

  shared_examples "access rights check" do |action|
    subject { described_class.new(article, user: user).apply(action) }

    context "when the user is not the author" do
      let(:user) { create :user }
      it { is_expected.to eq false }
    end

    context "when the user is the author" do
      let(:user) { article.user }
      it { is_expected.to eq true }
    end

    context "when the user is not authenticated" do
      let(:user) { nil }
      it { is_expected.to eq false }
    end
  end

  describe "#new?" do
    let(:user) { create :user }
    subject { described_class.new(article, user: user).apply(:new?) }

    it { is_expected.to eq true }
  end

  describe "#create?" do
    let(:user) { create :user }
    subject { described_class.new(article, user: user).apply(:create?) }

    it { is_expected.to eq true }
  end

  describe "#update?" do
    it_behaves_like "access rights check", :update?
  end

  describe "#edit?" do
    it_behaves_like "access rights check", :edit?
  end

  describe "#destroy?" do
    it_behaves_like "access rights check", :destroy?
  end
end
