describe Api::V1::UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "GET #show" do
    context "when user exists" do
      it "returns a successful response" do
        user = create :user
        get :show, params: { id: user.id }

        expect(response).to have_http_status(:ok)
      end

      it "returns the user as JSON, including full_name and articles" do
        user = create :user, first_name: "Test", last_name: "Test", age: 18
        articles = create_list :article, 2, user: user

        get :show, params: { id: user.id }
        json = JSON.parse(response.body)

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
        json = JSON.parse(response.body)
        expect(json["error"]).to eq("Couldn't find User with 'id'=9999")
      end
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new user and returns a created response with serialized data" do
        user_params = {
          first_name: "Test",
          last_name: "Test",
          age: 18,
          email: "test@test.com",
          password: "password123"
        }

        expect do
          post :create, params: { user: user_params }
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json["full_name"]).to eq("Test Test")
        expect(json["age"]).to eq(18)
      end
    end

    context "with invalid parameters" do
      it "does not create a user and returns errors" do
        user_params = { first_name: "", email: "invalid_email" }

        expect do
          post :create, params: { user: user_params }
        end.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json["errors"]).not_to be_empty
      end
    end
  end

  describe "POST #upload_avatar" do
    context "when user exists" do
      it "uploads avatar successfully" do
        user = create(:user)
        avatar_file = fixture_file_upload("avatar.jpg")

        post :upload_avatar, params: { id: user.id, avatar: avatar_file }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["message"]).to eq("Avatar uploaded successfully")
        expect(user.reload.avatar).to be_attached
      end
    end
  end
end
