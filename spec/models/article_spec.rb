require "rails_helper"
RSpec.describe Article, type: :model do
  it "is not valid without a title" do
    article = Article.new(body: "Test Content", status: "draft")
    expect(article).not_to be_valid
  end

  it "is not valid without a status" do
    article = Article.new(title: "Test Title", body: "Test Content")
    expect(article).not_to be_valid
  end

  it "is not valid with a status other than 'draft' or 'published'" do
    article = Article.new(title: "Test Title", body: "Test Content", status: "invalid_status")
    expect(article).not_to be_valid
  end
end
