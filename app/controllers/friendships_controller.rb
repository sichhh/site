class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @incoming_requests = current_user.inverse_friendships.where(status: "pending")
    @sent_requests = current_user.friendships.where(status: "pending")
  end

  def create
    result = Friendships::Create.call(friend_id: params[:friend_id], current_user: current_user)

    if result.success?
      redirect_to users_path, notice: "Запрос в друзья отправлен."
    else
      redirect_to users_path, alert: result.errors.full_messages.join(", ")
    end
  end

  def update
    result = Friendships::Update.call(id: params[:id])

    if result.success?
      redirect_to users_path(friends: true), notice: "Запрос в друзья принят."
    else
      redirect_to users_path, alert: result.errors.full_messages.join(", ")
    end
  end

  def destroy
    result = Friendships::Destroy.call(id: params[:id])

    if result.success?
      redirect_to friendship_path, notice: result.notice
    else
      redirect_to friendship_path, alert: result.errors.full_messages.join(", ")
    end
  end
end
