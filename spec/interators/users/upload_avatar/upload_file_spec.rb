RSpec.describe Users::UploadAvatar::UploadFile do
  subject(:call) { described_class.call(user: user, avatar: avatar) }

  let(:user) { create :user }
  let(:valid_avatar) { fixture_file_upload("avatar.jpg", "image/jpg") }
  let(:invalid_avatar) { fixture_file_upload("avatar.pdf") }

  describe ".call" do
    context "when a valid avatar is provided" do
      let(:avatar) { valid_avatar }
      it "attaches the avatar to the user" do
        expect { call }.to change { user.reload.avatar.attached? }.from(false).to(true)
      end
    end

    context "when an invalid avatar is provided" do
      let(:avatar) { invalid_avatar }

      it "does not attach the avatar" do
        expect { call }.not_to change { user.reload.avatar.attached? }
      end

      it "fails with an error message" do
        result = call
        expect(result).to be_a_failure
        expect(result.errors).to eq("Avatar must be a JPEG or PNG or JPG")
      end
    end

    context "when no avatar is provided" do
      let(:avatar) { nil }

      it "does not attach an avatar" do
        expect { call }.not_to change { user.reload.avatar.attached? }
      end

      it "succeeds without errors" do
        result = call
        expect(result).to be_a_success
      end
    end
  end
end
