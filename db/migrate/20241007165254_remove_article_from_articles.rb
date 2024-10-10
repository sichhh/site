class RemoveArticleFromArticles < ActiveRecord::Migration[7.1]
  def change
    remove_reference :articles, :article, index: true, foreign_key: true
  end
end
