class UsersSearchQuery
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 2

  def initialize(query, page, per_page)
    @query = query
    @page = page || DEFAULT_PAGE
    @per_page = per_page || DEFAULT_PER_PAGE
  end

  def call
    users = User.where(
      "first_name ILIKE :query OR last_name ILIKE :query OR email ILIKE :query",
      query: "%#{@query}%"
    )
    users = User.all if @query.blank?
    users.page(@page).per(@per_page)
  end

  private

  attr_reader :query, :page, :per_page
end
