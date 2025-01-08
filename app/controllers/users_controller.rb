class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[edit update]

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to articles_path
    else
      render :edit
    end
  end

  def index
    @users = UsersSearchQuery.new(
      params[:query],
      params[:page],
      params[:per_page],
      user_relation
    ).call
  end

  private

  def user_relation
    if params[:friends].present?
      User.where(id: current_user.friend_ids + current_user.inverse_friend_ids)
    else
      User.all
    end
  end

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :age, :avatar)
  end
end
