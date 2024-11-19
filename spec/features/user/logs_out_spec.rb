RSpec.feature "User Logout", type: :feature do
  let(:user) do
    create :user, first_name: "test", last_name: "test", email: "test@example.com", password: "securepassword"
  end

  scenario "user logs out" do
    visit new_user_session_path

    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password

    click_on "Log in"

    expect(page).to have_content("Welcome")

    click_on "Выход"

    expect(page).to have_content("Signed out successfully.")
  end
end
