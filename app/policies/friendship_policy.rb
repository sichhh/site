class FriendshipPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    user.present? && record.friend_id != user.id
  end

  def update?
    user.present? && (record.friend_id == user.id || record.user_id == user.id)
  end

  def destroy?
    user.present? && (record.user_id == user.id || record.friend_id == user.id)
  end
end
