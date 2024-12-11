RSpec.describe Article, type: :model do
  let(:article) { build :article }

  it "returns invalid article without a title" do
    article.title = nil
    expect(article).not_to be_valid
  end

  it "returns invalid article without a status" do
    article.status = nil
    expect(article).not_to be_valid
  end

  it "returns invalid article with a status other than 'draft' or 'published'" do
    article.status = "invalid_status"
    expect(article).not_to be_valid
  end
end
