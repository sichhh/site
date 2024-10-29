require "rails_helper"

RSpec.feature "Updating a Comment", type: :feature do
  include Features

  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  scenario "User can update their own comment" do
    article = create(:article, user: user)
    create(:comment, article: article, user: user)

    visit article_path(article)

    click_on "Edit Comment"

    click_on "Edit"

    fill_in "comment[body]", with: "Updated comment content."

    click_on "Update Comment"

    expect(page).to have_content("Updated comment content.")
  end
end
