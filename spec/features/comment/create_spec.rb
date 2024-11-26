RSpec.feature "Creating a Comment", type: :feature do
  include Features

  let(:user) { create :user }
  let!(:article) { create :article, user: user }

  before do
    sign_in(user)
  end

  scenario "creates comment" do
    visit article_path(article)

    fill_in "comment[body]", with: "This is a comment."
    click_on "Create Comment"

    expect(page).to have_content("This is a comment.")
  end
end
