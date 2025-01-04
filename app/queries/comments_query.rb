class CommentsQuery
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 2

  def initialize(comments, params)
    @comments = comments
    @page = params[:page] || DEFAULT_PAGE
    @per_page = params[:per] || DEFAULT_PER_PAGE
  end

  def call
    @comments.page(page).per(per_page)
  end

  private

  attr_reader :comments, :page, :per_page
end
