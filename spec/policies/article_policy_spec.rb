require "rails_helper"
RSpec.describe ArticlePolicy do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:other_user) { create(:user) }

  let(:policy) { described_class.new(article, user: user) }

  describe "#update?" do
    subject { policy.apply(:update?) }

    context "when the user is not the author" do
      let(:policy) { described_class.new(article, user: other_user) }
      it { is_expected.to eq false }
    end

    context "when the user is the author" do
      it { is_expected.to eq true }
    end

    context "when the user is not authenticated" do
      let(:policy) { described_class.new(article, user: nil) }
      it { is_expected.to eq false }
    end
  end

  describe "#edit?" do
    subject { policy.apply(:edit?) }

    context "when the user is not the author" do
      let(:policy) { described_class.new(article, user: other_user) }
      it { is_expected.to eq false }
    end

    context "when the user is the author" do
      it { is_expected.to eq true }
    end

    context "when the user is not authenticated" do
      let(:policy) { described_class.new(article, user: nil) }
      it { is_expected.to eq false }
    end

    describe "#destroy?" do
      subject { policy.apply(:destroy?) }

      context "when the user is not the author" do
        let(:policy) { described_class.new(article, user: other_user) }
        it { is_expected.to eq false }
      end

      context "when the user is the author" do
        it { is_expected.to eq true }
      end

      context "when the user is not authenticated" do
        let(:policy) { described_class.new(article, user: nil) }
        it { is_expected.to eq false }
      end
    end
  end
end
