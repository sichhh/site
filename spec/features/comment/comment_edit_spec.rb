require "rails_helper"

RSpec.feature "Creating a Comment", type: :feature do
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

  scenario "User can create a comment" do
    article = Article.create!(title: "Test Article", body: "This is a test article.", status: "public", user: user)
    visit article_path(article)

    fill_in "comment[body]", with: "This is a comment."
    click_on "Create Comment"

    expect(page).to have_content("Comments")
  end
end
