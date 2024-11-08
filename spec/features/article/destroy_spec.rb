RSpec.feature "Deleting an Article", type: :feature do
  include Features

  let(:user) { create :user }
  let!(:article) { create :article, user: user }

  before do
    sign_in(user)
  end

  scenario "User can delete their own article" do
    visit article_path(article)

    click_on "Destroy"

    expect(page).not_to have_content(article.title)
  end
end
