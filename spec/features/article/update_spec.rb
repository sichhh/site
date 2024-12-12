RSpec.feature "Updating an Article", type: :feature do
  include Features

  let(:user) { create :user }
  let!(:article) { create :article, user: user }

  before do
    sign_in(user)
  end

  scenario "update article" do
    visit article_path(article)

    click_on "Edit"

    fill_in "article[body]", with: "Updated article content."

    click_on "Save"

    expect(page).to have_content("Updated article content.")
  end
end
