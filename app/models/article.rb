class Article < ApplicationRecord
  include Visible
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 2 }
  scope :sorted_by, ->(field, sort_type) { order(field => sort_type) }
end
