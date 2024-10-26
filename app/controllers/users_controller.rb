class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[edit update destroy_avatar]

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to articles_path
    else
      render :edit
    end
  end

  def destroy_avatar
    @user.avatar.purge
    redirect_to articles_path
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :avatar)
  end
end
