class User < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_name_and_email,
                  against: %i[first_name last_name email],
                  using: {
                    tsearch: { prefix: false }
                  }

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 18 }

  def avatar_thumbnail
    avatar.variant(resize_to_limit: [300, 300]).processed
  end
end
