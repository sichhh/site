RSpec.feature "Deleting a Comment", type: :feature do
  include Features

  let(:user) { create :user }
  let!(:article) { create :article, user: user }
  let!(:comment) { create :comment, article: article, user: user }

  before do
    sign_in(user)
  end

  scenario "delete comment" do
    visit article_path(article)

    click_on "Destroy Comment"

    expect(page).not_to have_content(comment.body)
  end
end
