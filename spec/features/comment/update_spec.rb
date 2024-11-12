RSpec.feature "Updating a Comment", type: :feature do
  include Features

  let(:user) { create :user }
  let!(:article) { create :article, user: user }
  let!(:comment) { create :comment, article: article, user: user }

  before do
    sign_in(user)
  end

  scenario "update comment" do
    visit article_path(article)

    click_on "Edit Comment"

    click_on "Edit"

    fill_in "comment[body]", with: "Updated comment content."

    click_on "Update Comment"

    expect(page).to have_content("Updated comment content.")
  end
end
