require "rails_helper"

RSpec.feature "Создание статьи", type: :feature do
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

  scenario "пользователь может создать статью" do
    visit new_article_path

    fill_in "article[title]", with: "New Article"
    fill_in "article[body]", with: "Content of the new article."
    select "public", from: "article[status]"

    click_on "Create Article"
    expect(page).to have_content("New Article")
  end
end
