class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :friendships, dependent: :destroy, inverse_of: :user

  has_many :inverse_friendships,
           class_name: "Friendship",
           foreign_key: "friend_id",
           dependent: :destroy,
           inverse_of: :friend

  has_many :friend_friendships,
           -> { friends },
           class_name: "Friendship",
           foreign_key: "user_id",
           dependent: :destroy,
           inverse_of: :user

  has_many :friends, through: :friend_friendships, source: :friend

  has_many :inverse_friend_friendships,
           -> { friends },
           class_name: "Friendship",
           foreign_key: "friend_id",
           dependent: :destroy,
           inverse_of: :user

  has_many :inverse_friends, through: :inverse_friend_friendships, source: :friend

  has_one_attached :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 18 }
  validates :avatar, content_type: %i[png jpg jpeg webp]

  def avatar_thumbnail
    avatar.variant(resize_to_limit: [300, 300]).processed
  end
end
