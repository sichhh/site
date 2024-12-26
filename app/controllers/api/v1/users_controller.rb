module Api
  module V1
    class UsersController < ApplicationController
      def show
        user = User.find(params[:id])
        render json: user
      end

      def create
        user = User.new(user_params)

        if user.save
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def upload_avatar
        user = User.find(params[:id])
        result = Users::UploadAvatar.call(user: user, avatar: avatar_params[:avatar],
                                          avatar_url: avatar_params[:avatar_url])

        if result.success?
          render json: { message: "Avatar uploaded successfully" }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :age, :email, :password)
      end

      def avatar_params
        params.permit(:avatar, :avatar_url)
      end
    end
  end
end
