RSpec.feature "Viewing Articles", type: :feature do
  include Features

  let(:user) { create :user }
  let(:article) { create :article, user: user }

  scenario "Guest user can see articles" do
    visit article_path(article)
    expect(page).to have_content(article.title)
  end

  scenario "Registered user can see all articles" do
    sign_in(user)
    visit article_path(article)
    expect(page).to have_content(article.title)
  end
end
