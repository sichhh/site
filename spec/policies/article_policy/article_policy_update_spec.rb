require "rails_helper"

RSpec.describe ArticlePolicy do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:other_user) { create(:user) }

  shared_examples "проверка прав доступа" do |action|
    subject { policy.apply(action) }

    context "когда пользователь не автор" do
      let(:policy) { described_class.new(article, user: other_user) }
      it { is_expected.to eq false }
    end

    context "когда пользователь - автор" do
      let(:policy) { described_class.new(article, user: user) }
      it { is_expected.to eq true }
    end

    context "когда пользователь не авторизован" do
      let(:policy) { described_class.new(article, user: nil) }
      it { is_expected.to eq false }
    end
  end

  describe "#update?" do
    it_behaves_like "проверка прав доступа", :update?
  end
end
