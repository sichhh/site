class ArticlePage
  def initialize(params)
    @params = params
  end

  def call
    order = @params[:order] || "desc"
    sort_by = @params[:sort_by] || "created_at"

    if sort_by == "title"
      Article.sorted_by_title(order).page(@params[:page]).per(2)
    else
      Article.sorted_by(order).page(@params[:page]).per(2)
    end
  end
end
