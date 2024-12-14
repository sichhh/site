RSpec.describe CommentsQuery do
  let(:query) { described_class.new(comments, page: page, per: per_page) }
  let(:result) { query.call }
  let(:page) { 1 }
  let(:per_page) { 2 }

  let!(:comment1) { create :comment, body: "This is the first comment" }
  let!(:comment2) { create :comment, body: "This is the second comment" }
  let!(:comment3) { create :comment, body: "This is the third comment" }
  let!(:comment4) { create :comment, body: "This is the fourth comment" }
  let!(:comment5) { create :comment, body: "This is the fifth comment" }

  let(:comments) { Comment.all }

  it "returns the comments for the first page" do
    expect(result).to match_array([comment1, comment2])
  end

  context "when page is 2" do
    let(:page) { 2 }
    
    it "returns the second page of comments" do
      expect(result).to match_array([comment3, comment4])
    end
  end

  context "when per_page is 1" do
    let(:per_page) { 1 }
    
    it "returns only one comment per page" do
      expect(result).to match_array([comment1])
    end
  end

  context "when per_page is greater than the total number of comments" do
    let(:per_page) { 10 }

    it "returns all comments" do
      expect(result).to match_array([comment1, comment2, comment3, comment4, comment5])
    end
  end

  context "when default values are used" do
    let(:page) { nil }
    let(:per_page) { nil }

    it "returns the first page with the default per_page" do
      expect(result).to match_array([comment1, comment2])
    end
  end

  context "when there are no comments" do
    let(:comments) { Comment.none }

    it "returns an empty array" do
      expect(result).to be_empty
    end
  end
end
