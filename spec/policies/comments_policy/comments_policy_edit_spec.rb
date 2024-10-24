require "rails_helper"

RSpec.describe CommentPolicy do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:comment) { create(:comment, article: article, user: user) }
  let(:other_user) { create(:user) }

  shared_examples "проверка прав доступа" do |action|
    subject { policy.apply(action) }

    context "когда пользователь не автор" do
      let(:policy) { described_class.new(comment, user: other_user) }
      it { is_expected.to eq false }
    end

    context "когда пользователь - автор" do
      let(:policy) { described_class.new(comment, user: user) }
      it { is_expected.to eq true }
    end

    context "когда пользователь не авторизован" do
      let(:policy) { described_class.new(comment, user: nil) }
      it { is_expected.to eq false }
    end
  end

  describe "#edit?" do
    it_behaves_like "проверка прав доступа", :edit?
  end
end
