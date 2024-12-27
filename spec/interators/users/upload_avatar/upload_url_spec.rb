RSpec.describe Users::UploadAvatar::UploadUrl do
  subject(:call) { described_class.call(user: user, avatar_url: avatar_url) }

  let(:user) { create :user }
  let(:avatar_url) { "http://example.com/avatar.jpg" }

  describe ".call" do
    context "when avatar_url is provided" do
      before do
        stub_request(:get, avatar_url)
          .to_return(
            status: 200,
            body: "fake file content",
            headers: { "Content-Type" => "image/jpeg" }
          )
      end

      it "attaches the avatar to the user from the URL" do
        expect { call }.to change { user.reload.avatar.attached? }.from(false).to(true)
      end
    end

    context "when avatar_url is not provided" do
      let(:avatar_url) { nil }

      it "does not attach an avatar" do
        expect { call }.not_to change { user.reload.avatar.attached? }
      end
    end
  end
end
