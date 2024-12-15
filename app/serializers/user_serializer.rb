class UserSerializer < ActiveModel::Serializer
  attributes :full_name, :age, :articles

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def articles
    object.articles.map do |article|
      { id: article.id, title: article.title, body: article.body }
    end
  end
end
