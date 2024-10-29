require "rails_helper"

RSpec.feature "Creating a Comment", type: :feature do
  include Features

  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  scenario "User can create a comment" do
    article = create(:article, user: user)
    visit article_path(article)

    fill_in "comment[body]", with: "This is a comment."
    click_on "Create Comment"

    expect(page).to have_content("This is a comment.")
  end
end
