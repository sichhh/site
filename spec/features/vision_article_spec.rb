RSpec.feature "Viewing Articles", type: :feature do
  let!(:user) do
    User.create!(first_name: "Denis", last_name: "Zaharov", age: 25, email: "denis@example.com",
                 password: "securepassword")
  end

  scenario "Guest user can see articles" do
    article = Article.create!(title: "Test Article",
                              body: "This is a test article.",
                              status: "public",
                              user: user)

    visit articles_path

    expect(page).to have_content(article.title)
  end

  scenario "Registered user can see all articles" do
    article = Article.create!(title: "Test Article",
                              body: "This is a test article.",
                              status: "public",
                              user: user)

    visit articles_path

    expect(page).to have_content(article.title)
  end
end
