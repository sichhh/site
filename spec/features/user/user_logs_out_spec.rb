require "rails_helper"

RSpec.feature "Выход из системы", type: :feature do
  scenario "пользователь выходит из системы" do
    User.create!(first_name: "Denis", last_name: "Zaharov", age: 25,
                 email: "denis@example.com", password: "securepassword")
    visit new_user_session_path

    fill_in "user[email]", with: "denis@example.com"
    fill_in "user[password]", with: "securepassword"

    click_on "Log in"

    expect(page).to have_content("Welcome, Denis!")

    click_on "Выход"

    expect(page).to have_content("Signed out successfully.")
  end
end
