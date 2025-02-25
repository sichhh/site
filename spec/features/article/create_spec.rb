RSpec.feature "Creating an Article", type: :feature do
  include Features

  let(:user) { create :user }

  before do
    sign_in(user)
  end

  scenario "creates article" do
    visit new_article_path

    fill_in "article[title]", with: "New Article"
    fill_in "article[body]", with: "Content of the new article."
    select "public", from: "article[status]"

    click_on "Save"
    expect(page).to have_content("New Article")
  end
end
