describe Article, type: :model do
  it "returns invalid article without a title" do
    article = Article.new(body: "Test Content", status: "draft")
    expect(article).not_to be_valid
  end

  it "returns invalid article without a status" do
    article = Article.new(title: "Test Title", body: "Test Content")
    expect(article).not_to be_valid
  end

  it "returns invalid article with a status other than 'draft' or 'published'" do
    article = Article.new(title: "Test Title", body: "Test Content", status: "invalid_status")
    expect(article).not_to be_valid
  end
end
