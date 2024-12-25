class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar

  after_create :attach_default_avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 18 }
  validates :avatar, content_type: %i[png jpg jpeg webp]

  def avatar_thumbnail
    avatar.variant(resize_to_limit: [300, 300]).processed
  end

  def attach_default_avatar
    return if avatar.attached?

    default_avatar_path = Rails.root.join("app/assets/images/default_avatar.webp")
    avatar.attach(io: File.open(default_avatar_path), filename: "default_avatar.webp", content_type: "image/png")
  end
end
