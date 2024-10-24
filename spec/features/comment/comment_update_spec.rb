require "rails_helper"

RSpec.feature "обновление коментария", type: :feature do
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

  scenario "пользователь может обновить свой комментарий" do
    article = Article.create!(title: "Test Article",
                              body: "This is a test article.",
                              status: "public",
                              user: user)
    Comment.create!(body: "Comment to be updated", status: "public", article: article, user: user)

    visit article_path(article)

    click_on "Edit Comment"

    click_on "Edit"

    fill_in "comment[body]", with: "Updated comment content." # Исправляем на 'body'

    click_on "Update Comment"

    expect(page).to have_content("Comments")
  end
end
