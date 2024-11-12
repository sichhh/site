RSpec.describe ArticlePolicy do
  let(:user) { create :user }
  let(:article) { create :article, user: user }
  let(:other_user) { create :user }

  shared_examples "access rights check" do |action|
    subject { policy.apply(action) }

    context "when the user is not the author" do
      let(:policy) { described_class.new(article, user: other_user) }
      it { is_expected.to eq false }
    end

    context "when the user is the author" do
      let(:policy) { described_class.new(article, user: user) }
      it { is_expected.to eq true }
    end

    context "when the user is not authenticated" do
      let(:policy) { described_class.new(article, user: nil) }
      it { is_expected.to eq false }
    end
  end

  describe "#new?" do
    subject { policy.apply(:new?) }

    context "when the user is authenticated" do
      let(:policy) { described_class.new(article, user: user) }
      it { is_expected.to eq true }
    end

    context "when the user is not authenticated" do
      let(:policy) { described_class.new(article, user: nil) }
      it { is_expected.to eq false }
    end
  end

  describe "#create?" do
    subject { policy.apply(:create?) }

    context "when the user is authenticated" do
      let(:policy) { described_class.new(article, user: user) }
      it { is_expected.to eq true }
    end

    context "when the user is not authenticated" do
      let(:policy) { described_class.new(article, user: nil) }
      it { is_expected.to eq false }
    end
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
