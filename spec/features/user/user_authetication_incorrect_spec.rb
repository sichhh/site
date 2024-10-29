require "rails_helper"

RSpec.feature "User Authentication with Incorrect Credentials", type: :feature do
  let(:user) do
    create(:user, first_name: "test", last_name: "test", email: "test@example.com", password: "securepassword")
  end

  scenario "user tries to log in with incorrect password" do
    visit new_user_session_path

    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: "wrongpassword"

    click_on "Log in"

    expect(page).to have_content("Invalid Email or password.")
  end

  scenario "user tries to log in with incorrect email" do
    visit new_user_session_path

    fill_in "user[email]", with: "unregistered@example.com"
    fill_in "user[password]", with: "securepassword"

    click_on "Log in"

    expect(page).to have_content("Invalid Email or password.")
  end
end
