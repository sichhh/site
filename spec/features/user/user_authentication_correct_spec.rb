require "rails_helper"

RSpec.feature "User Registration", type: :feature do
  let(:user) do
    build(:user, first_name: "test", last_name: "test", email: "test@example.com", password: "securepassword")
  end

  scenario "user successfully registers" do
    visit new_user_registration_path

    within("#new_user") do
      fill_in "First name", with: user.first_name
      fill_in "Last name", with: user.last_name
      fill_in "Age", with: 25
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      fill_in "Password confirmation", with: user.password
    end

    click_on "Sign up"

    expect(page).to have_content("Welcome")
  end
end

RSpec.feature "User Login", type: :feature do
  let(:user) do
    create(:user, first_name: "test", last_name: "test", email: "test@example.com", password: "securepassword")
  end

  scenario "user logs in with correct credentials" do
    visit new_user_session_path

    within("#new_user") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
    end

    click_on "Log in"

    expect(page).to have_content("Welcome")
  end
end
