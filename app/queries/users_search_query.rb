class UsersSearchQuery
  def initialize(params)
    @params = params
  end

  def call
    if @params[:query].present?
      User.search_by_name_and_email(@params[:query])
    else
      User.all
    end
  end
end
