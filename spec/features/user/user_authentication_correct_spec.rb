require "rails_helper"

RSpec.feature "Аутентификация пользователя", type: :feature do
  scenario "пользователь успешно регистрируется" do
    visit new_user_registration_path

    fill_in "user[first_name]", with: "Denis"
    fill_in "user[last_name]", with: "Zaharov"
    fill_in "user[age]", with: "25"
    fill_in "user[email]", with: "denis@example.com"
    fill_in "user[password]", with: "securepassword"
    fill_in "user[password_confirmation]", with: "securepassword"

    click_on "Sign up"

    expect(page).to have_content("Welcome, Denis!")
  end

  scenario "пользователь входит в систему с корректными данными" do
    User.create!(first_name: "Denis", last_name: "Zaharov", age: 25,
                 email: "denis@example.com", password: "securepassword")

    visit new_user_session_path

    fill_in "user[email]", with: "denis@example.com"
    fill_in "user[password]", with: "securepassword"

    click_on "Log in"

    expect(page).to have_content("Welcome, Denis!")
  end
end
