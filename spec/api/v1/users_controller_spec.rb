describe Api::V1::UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create :user, first_name: "Test", last_name: "Test", age: 18 }
  let(:json) { JSON.parse(response.body) }
  let!(:articles) { create_list :article, 2, user: user }

  describe "GET #show" do
    context "when user exists" do
      it "returns a successful response" do
        get :show, params: { id: user.id }

        expect(response).to have_http_status(:ok)
      end

      it "returns the user as JSON, including full_name and articles" do

        get :show, params: { id: user.id }

        expect(json["full_name"]).to eq("Test Test")
        expect(json["age"]).to eq(18)
        expect(json["articles"].size).to eq(2)
        expect(json["articles"].first["title"]).to eq(articles.first.title)
      end
    end

    context "when user does not exist" do
      it "returns a not found response" do
        get :show, params: { id: 9999 }

        expect(response).to have_http_status(:not_found)
        expect(json["error"]).to eq("Couldn't find User with 'id'=9999")
      end
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_user_params) do
        {
          first_name: "Test",
          last_name: "Test",
          age: 18,
          email: "test@test.com",
          password: "password123"
        }
      end

      it "creates a new user and returns a created response with serialized data" do
        expect do
          post :create, params: { user: valid_user_params }
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(json["full_name"]).to eq("Test Test")
        expect(json["age"]).to eq(18)
      end
    end

    context "with invalid parameters" do
      let(:invalid_user_params) { { first_name: "", email: "invalid_email" } }

      it "does not create a user and returns errors" do
        expect do
          post :create, params: { user: invalid_user_params }
        end.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json["errors"]).not_to be_empty
      end
    end
  end

  describe "POST #upload_avatar" do
    let(:avatar_file) { fixture_file_upload("avatar.jpg") }

    context "when user exists" do
      it "uploads avatar successfully" do
        post :upload_avatar, params: { id: user.id, avatar: avatar_file }

        expect(response).to have_http_status(:ok)
        expect(json["message"]).to eq("Avatar uploaded successfully")
        expect(user.reload.avatar).to be_attached
      end
    end

    context "when user does not exist" do
      it "returns a not found response" do
        post :upload_avatar, params: { id: 9999, avatar: avatar_file }

        expect(response).to have_http_status(:not_found)
        expect(json["error"]).to eq("Couldn't find User with 'id'=9999")
      end
    end
  end
end
