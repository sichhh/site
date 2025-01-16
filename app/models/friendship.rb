class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  enum status: { pending: "pending", accepted: "accepted", rejected: "rejected" }

  validates :status, presence: true

  after_create :send_friend_request_email

  private

  def send_friend_request_email
    UserMailer.friend_request_email(self).deliver_later
  end
end
