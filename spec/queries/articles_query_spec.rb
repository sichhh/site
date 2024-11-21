RSpec.describe ArticlesQuery do
  let!(:articles) { create_list(:article, 10) }

  shared_examples_for "articles query" do |field, sort_type, page, per|
    let(:query) { described_class.new(field: field, sort_type: sort_type, page: page, per: per) }

    it "returns articles sorted" do
      result = query.call

      expect(result.count).to be <= per
      expect(result.current_page).to eq(page)
      expect(result.order_values).to eq([Article.arel_table[field].send(sort_type)])
    end
  end

  describe "#call" do
    context "with valid params" do
      it_behaves_like "articles query", :title, :asc, 2, 2
      it_behaves_like "articles query", :created_at, :desc, 1, 2
      it_behaves_like "articles query", :updated_at, :asc, 3, 3
    end

    context "with invalid params" do

      it "returns articles is invalid" do
        query = described_class.new(field: :title, sort_type: :asc, page: 0, per: 2)
        result = query.call

        expect(result.count).to eq(ArticlesQuery::DEFAULT_PER_PAGE)
        expect(result.current_page).to eq(ArticlesQuery::DEFAULT_PAGE)
        expect(result.order_values).to eq([Article.arel_table[:title].asc])
      end
    end
  end
end 
