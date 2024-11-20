class ArticlesQuery
  DEFAULT_FIELD_FOR_SORT = "created_at".freeze
  DEFAULT_SORT_TYPE = "desc".freeze
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 2

  def initialize(params)
    @field = params[:field] || DEFAULT_FIELD_FOR_SORT
    @sort_type = params[:sort_type] || DEFAULT_SORT_TYPE
    @page = params[:page] || DEFAULT_PAGE
    @per_page = params[:per] || DEFAULT_PER_PAGE
  end

  def call
    Article.sorted_by(field, sort_type).page(page).per(per_page)
  end

  private

  attr_reader :field, :sort_type, :page, :per_page 
end
