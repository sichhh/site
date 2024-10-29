require "rails_helper"

RSpec.feature "Deleting a Comment", type: :feature do
  include Features

  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  scenario "User can delete their own comment" do
    article = create(:article, user: user)
    comment = create(:comment, article: article, user: user)

    visit article_path(article)

    click_on "Destroy Comment"

    expect(page).not_to have_content(comment.body)
  end
end
