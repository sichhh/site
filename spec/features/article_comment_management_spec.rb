require "rails_helper"

RSpec.feature "Управление статьями и комментариями", type: :feature do
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
    select "public", from: "article[status]" # Убедитесь, что значение соответствует вашим нуждам

    click_on "Create Article"

    expect(page).to have_content("New Article")
  end

  scenario "пользователь может обновить свою статью" do
    article = Article.create!(title: "Test Article", body: "This is a test article.", status: "public", user: user)

    visit edit_article_path(article)

    fill_in "article[title]", with: "Updated Article"
    fill_in "article[body]", with: "Updated content for the article."
    select "public", from: "article[status]" # Убедитесь, что статус корректен при обновлении

    click_on "Update Article"

    expect(page).to have_content("Edit")
  end

  scenario "пользователь может удалить свою статью" do
    article = Article.create!(title: "Test Article", body: "This is a test article.", status: "public", user: user)

    visit article_path(article)

    click_on "Destroy"

    expect(page).not_to have_content(article.title)
  end

  scenario "пользователь может создать комментарий" do
    article = Article.create!(title: "Test Article", body: "This is a test article.", status: "public", user: user)
    visit article_path(article)

    fill_in "comment[body]", with: "This is a comment." # Исправляем на 'body'
    click_on "Create Comment"

    expect(page).to have_content("Comments")
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

  scenario "пользователь может удалить свой комментарий" do
    article = Article.create!(title: "Test Article",
                              body: "This is a test article.",
                              status: "public",
                              user: user)
    comment = Comment.create!(body: "Comment to be updated", status: "public", article: article, user: user)

    visit article_path(article)

    click_on "Destroy Comment"

    expect(page).not_to have_content(comment.body) # Исправляем на 'body'
  end

  scenario "гостевой пользователь видит статьи" do
    article = Article.create!(title: "Test Article",
                              body: "This is a test article.",
                              status: "public",
                              user: user)

    visit articles_path

    expect(page).to have_content(article.title)
  end

  scenario "зарегистрированный пользователь видит все статьи" do
    article = Article.create!(title: "Test Article",
                              body: "This is a test article.",
                              status: "public",
                              user: user)

    visit articles_path

    expect(page).to have_content(article.title)
  end
end
