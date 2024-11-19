RSpec.feature "Password Reset", type: :feature do
  let(:user) { create :user }

  scenario "reset password" do
    visit new_user_session_path

    click_on "Forgot your password?"

    fill_in "user[email]", with: user.email

    click_on "Send me reset password instructions"

    expect(page).to have_content("You will receive an email with instructions")
  end
end
