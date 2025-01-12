RSpec.describe UsersSearchQuery do
  let(:relation) { User.all }
  let(:query) { described_class.new(search_query, page, per_page, relation) }
  let(:result) { query.call }
  let(:search_query) { "test" }
  let(:page) { 1 }
  let(:per_page) { 4 }

  let!(:user1) { create :user, first_name: "Test", last_name: "User1", email: "abc1@example.com" }
  let!(:user2) { create :user, first_name: "Another", last_name: "User2", email: "abc2@example.com" }
  let!(:user3) { create :user, first_name: "Test", last_name: "User3", email: "abc3@example.com" }
  let!(:user4) { create :user, first_name: "User4", last_name: "Test", email: "abc4@example.com" }
  let!(:user5) { create :user, first_name: "User5", last_name: "User5", email: "test5@example.com" }

  it "returns users matching the query" do
    expect(result).to match_array([user1, user3, user4, user5])
  end

  context "when query is blank" do
    let(:per_page) { 2 }
    let(:search_query) { "" }

    it "returns all users" do
      expect(result.count).to eq(2)
    end
  end

  context "when page is 2" do
    let(:per_page) { 2 }
    let(:page) { 2 }

    it "returns the second page of users" do
      expect(result).to match_array([user4, user5])
    end
  end

  context "when per_page is 1" do
    let(:per_page) { 1 }

    it "returns only one user per page" do
      expect(result).to match_array([user1])
    end
  end

  context "when default values are used" do
    let(:search_query) { nil }
    let(:page) { nil }
    let(:per_page) { nil }

    it "returns the first page with default per_page" do
      expect(result).to match_array([user1, user2])
    end
  end
end
