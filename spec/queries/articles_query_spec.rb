RSpec.describe ArticlesQuery do
  let(:field) { 'title' }
  let(:sort_type) { 'asc' }
  let(:page) { 1 }
  let(:per) { 3 }

  let!(:article1) { create :article, title: 'hehe' }
  let!(:article2) { create :article, title: 'loh' }
  let!(:article3) { create :article, title: 'aaa' }
  let!(:article4) { create :article, title: 'xxx' }
  let!(:article5) { create :article, title: 'jija' }

  context "successful scenarios" do
    it "returns articles sorted by title in ascending order" do
      query = described_class.new(field: field, sort_type: sort_type, page: page, per: per)
      result = query.call
      expect(result).to match_array([article3, article1, article5])
    end

    it "returns articles sorted by title in descending order" do
      query = described_class.new(field: field, sort_type: 'desc', page: page, per: per)
      result = query.call
      expect(result).to match_array([article4, article2, article5]) 
    end

    it "returns the correct number of articles per page" do
      query = described_class.new(field: field, sort_type: sort_type, page: page, per: per)
      result = query.call
      expect(result.size).to eq(per) 
    end

    it "returns the correct total pages count" do
      query = described_class.new(field: field, sort_type: sort_type, page: page, per: per)
      expect(query.total_pages).to eq(2)
    end
  end

  context "unsuccessful scenarios" do
    it "returns an empty array if there are no articles on the requested page" do
      query = described_class.new(field: field, sort_type: sort_type, page: 3, per: 3)
      result = query.call
      expect(result).to be_empty
    end

    it "handles invalid sort types gracefully" do
      query = described_class.new(field: field, sort_type: 'invalid_sort_type', page: page, per: per)
      expect { query.call }.to raise_error(ArgumentError)
    end
  end
end 
