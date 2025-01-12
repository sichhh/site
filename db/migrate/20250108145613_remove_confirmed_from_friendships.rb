class RemoveConfirmedFromFriendships < ActiveRecord::Migration[7.1]
  def change
    remove_column :friendships, :confirmed, :boolean
  end
end
