class ArticlesQuery
  def initialize(params)
    @params = params
  end

  def call
    field = @params[:sort_by] || "created_at"
    order = @params[:order] || "desc"

    Article.sorted_by(field, order).page(@params[:page]).per(2)
  end
end
