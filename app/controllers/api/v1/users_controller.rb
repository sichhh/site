module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token

      def show
        user = User.find(params[:id])
        render json: UserSerializer.new(user).serializable_hash
      rescue ActiveRecord::RecordNotFound
        render json: { error: "User not found" }, status: :not_found
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: UserSerializer.new(user).serializable_hash, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def upload_avatar
        user = User.find(params[:id])
        if user.update(avatar: params[:avatar])
          render json: { message: "Avatar uploaded successfully" }, status: :ok
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "User not found" }, status: :not_found
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :age, :email, :password)
      end
    end
  end
end
