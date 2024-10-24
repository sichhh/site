require "rails_helper"

RSpec.feature "Аутентификация пользователя с некорректными даными", type: :feature do
  scenario "пользователь пытается войти в систему с некорректным паролем" do
    User.create!(first_name: "Denis", last_name: "Zaharov", age: 25,
                 email: "denis@example.com", password: "securepassword")

    visit new_user_session_path

    fill_in "user[email]", with: "denis@example.com"
    fill_in "user[password]", with: "wrongpassword"

    click_on "Log in"

    expect(page).to have_content("Invalid Email or password.")
  end

  scenario "пользователь пытается войти в систему с некорректным email" do
    User.create!(first_name: "Denis", last_name: "Zaharov", age: 25,
                 email: "denis@example.com", password: "securepassword")

    visit new_user_session_path

    fill_in "user[email]", with: "unregistered@example.com"
    fill_in "user[password]", with: "somepassword"

    click_on "Log in"

    expect(page).to have_content("Invalid Email or password.")
  end
end
