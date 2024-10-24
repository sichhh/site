require "rails_helper"

RSpec.feature "виденье статьи", type: :feature do
  let!(:user) do
    User.create!(first_name: "Denis", last_name: "Zaharov", age: 25, email: "denis@example.com",
                 password: "securepassword")
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
