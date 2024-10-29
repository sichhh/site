require "rails_helper"

RSpec.feature "Deleting an Article", type: :feature do
  include Features

  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  scenario "User can delete their own article" do
    article = create(:article, user: user)

    visit article_path(article)

    click_on "Destroy"

    expect(page).not_to have_content(article.title)
  end
end
