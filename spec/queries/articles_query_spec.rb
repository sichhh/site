RSpec.describe ArticlesQuery do
  let(:query) { described_class.new(field: field, sort_type: sort_type, page: page, per: per) }
  let(:result) { query.call }
  let(:field) { 'title' }
  let(:sort_type) { 'asc' }
  let(:page) { 1 }
  let(:per) { 3 }

  let!(:article1) { create :article, title: "hehe", body: "aaaaaaaaaaaa", created_at: 1.day.ago }
  let!(:article2) { create :article, title: "loh", body: "bbbbbbbbbbbb", created_at: 1.week.ago }
  let!(:article3) { create :article, title: "aaa", body: "cccccccccccc", created_at: 1.month.ago }
  let!(:article4) { create :article, title: "xxx", body: "ddddddddddd", created_at: 2.months.ago }
  let!(:article5) { create :article, title: "jija", body: "eeeeeeeeee", created_at: 1.year.ago }

  it "returns articles" do
    expect(result).to match_array([article3, article1, article5])
  end

  context "when 1 article on page" do
    let(:per) { 1 }

    it "returns articles" do
      expect(result).to match_array([article3])
    end
  end

  context "when second page" do
    let(:page) { 2 }

    it "returns articles" do
      expect(result).to match_array([article4, article2])
    end
  end

  context "when descending order" do
    let(:sort_type) { "desc" }

    it "returns articles" do
      expect(result).to match_array([article4, article2, article5])
    end
  end

  context "when sort by body" do
    let(:field) { "body" }

    it "returns articles" do
      expect(result).to match_array([article1, article2, article3])
    end
  end

  context "with blank params" do
    let(:field) { nil }
    let(:sort_type) { nil }
    let(:page) { nil }
    let(:per) { nil }

    it "returns articles" do
      expect(result).to match_array([article1, article2])
    end
  end

  context "when invalid sort type" do
    let(:sort_type) { "invalid_sort_type" }

    it "raises error" do
      expect { result }.to raise_error(ArgumentError)
    end
  end
end
