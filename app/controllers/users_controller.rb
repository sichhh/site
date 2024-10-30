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

  def search
    @users = User.where("first_name ILIKE ? OR last_name ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :age, :avatar)
  end
end
