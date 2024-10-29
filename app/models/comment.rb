class Comment < ApplicationRecord
  include Visible
  belongs_to :article
  belongs_to :user

  validates :body, presence: true
  validates :user_id, presence: true 
end