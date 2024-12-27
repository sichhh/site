class UserSerializer < ActiveModel::Serializer
  attributes :full_name, :age
  has_many :articles, serializer: ::ArticleSerializer

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
