class CommentPolicy < ActionPolicy::Base
  def create?
    user.present?
  end

  def update?
    user == record.user
  end

  def destroy?
    user == record.user || user == record.article.user
  end

  def edit?
    update?
  end
end
