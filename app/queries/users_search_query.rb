class UsersSearchQuery
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 2

  def initialize(query, page, per_page, relation)
    @relation = relation
    @query = query
    @page = page || DEFAULT_PAGE
    @per_page = per_page || DEFAULT_PER_PAGE
  end

  def call
    users = search_users(query)
    users.page(page).per(per_page)
  end

  private

  attr_reader :query, :page, :per_page, :relation

  def search_users(query)
    if query.blank?
      relation
    else
      relation.where("first_name ILIKE :query OR last_name ILIKE :query OR email ILIKE :query",
                     query: "%#{@query}%")
    end
  end
end
