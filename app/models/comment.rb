class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user

  validates :body, presence: true
  validates :status, inclusion: { in: %w[public private], message: "%<value>s is not a valid status" }
  def archived?
    status == "archived"
  end
end
