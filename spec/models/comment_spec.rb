describe Comment, type: :model do
  it "returns invalid comment without a commenter" do
    comment = Comment.new(body: "This is a comment", status: "visible")
    expect(comment).not_to be_valid
  end

  it "returns invalid comment without a body" do
    comment = Comment.new(commenter: "Test User", status: "visible")
    expect(comment).not_to be_valid
  end

  it "returns invalid comment without a status" do
    comment = Comment.new(commenter: "Test User", body: "This is a comment")
    expect(comment).not_to be_valid
  end

  it "returns invalid comment with a status other than 'visible' or 'hidden'" do
    comment = Comment.new(commenter: "Test User", body: "This is a comment", status: "invalid_status")
    expect(comment).not_to be_valid
  end
end
