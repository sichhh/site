require "rails_helper"

RSpec.feature "обновление  статьи", type: :feature do
  let!(:user) do
    User.create!(first_name: "Denis", last_name: "Zaharov", age: 25, email: "denis@example.com",
                 password: "securepassword")
  end

  before do
    visit new_user_session_path
    fill_in "user[email]", with: "denis@example.com"
    fill_in "user[password]", with: "securepassword"
    click_on "Log in"
  end

  scenario "пользователь может обновить свою статью" do
    article = Article.create!(title: "Test Article", body: "This is a test article.", status: "public", user: user)

    visit edit_article_path(article)

    fill_in "article[title]", with: "Updated Article"
    fill_in "article[body]", with: "Updated content for the article."
    select "public", from: "article[status]"

    click_on "Update Article"
    expect(page).to have_content("Edit")
  end
end
