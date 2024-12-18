RSpec.describe Avatars::Upload, type: :interactor do
  let(:user) { create :user }
  let(:avatar_file) { fixture_file_upload("avatar.jpg", "image/jpg") }
  let(:avatar_url) { "https://example.com/avatar.jpg" }

  describe ".call" do
    before do
      stub_request(:get, avatar_url)
        .to_return(
          status: 200,
          body: "fake avatar content",
          headers: { "Content-Type" => "image/jpeg" }
        )
    end

    context "when both file and URL are provided" do
      let(:call) { described_class.call(user: user, avatar: avatar_file, avatar_url: avatar_url) }

      it "organizes UploadFile and UploadUrl interactors" do
        expect(described_class.organized).to eq([Avatars::Upload::UploadFile, Avatars::Upload::UploadUrl])
      end

      it "attaches the file avatar to the user" do
        expect { call }.to change { user.reload.avatar.attached? }.from(false).to(true)
      end
    end

    context "when only avatar file is provided" do
      let(:call) { described_class.call(user: user, avatar: avatar_file) }

      it "attaches the file avatar to the user" do
        expect { call }.to change { user.reload.avatar.attached? }.from(false).to(true)
      end
    end

    context "when only avatar URL is provided" do
      let(:call) { described_class.call(user: user, avatar_url: avatar_url) }

      it "attaches the avatar from the URL to the user" do
        expect { call }.to change { user.reload.avatar.attached? }.from(false).to(true)
      end
    end

    context "when neither avatar file nor URL is provided" do
      let(:call) { described_class.call(user: user) }

      it "does not attach any avatar" do
        expect { call }.not_to change { user.reload.avatar.attached? }
      end

      it "does not fail and succeeds gracefully" do
        expect(call).to be_a_success
      end
    end
  end
end
