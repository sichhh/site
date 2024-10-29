require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:comment) { build(:comment) }

  it "returns invalid comment without a commenter" do
    comment.commenter = nil
    expect(comment).not_to be_valid
  end

  it "returns invalid comment without a body" do
    comment.body = nil
    expect(comment).not_to be_valid
  end

  it "returns invalid comment without a status" do
    comment.status = nil
    expect(comment).not_to be_valid
  end

  it "returns invalid comment with a status other than 'visible' or 'hidden'" do
    comment.status = "invalid_status"
    expect(comment).not_to be_valid
  end
end
