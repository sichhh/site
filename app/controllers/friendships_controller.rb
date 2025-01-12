class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: %i[update destroy]

  def index
    @incoming_requests = current_user.inverse_friendships.pending
    @sent_requests = current_user.friendships.pending

    authorize! Friendship
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
    authorize! @friendship

    result = Friendships::Update.call(id: @friendship.id)

    if result.success?
      redirect_to users_path(friends: true), notice: "Запрос в друзья принят."
    else
      redirect_to users_path, alert: result.errors.full_messages.join(", ")
    end
  end

  def destroy
    authorize! @friendship

    result = Friendships::Destroy.call(id: @friendship.id)

    if result.success?
      redirect_to friendship_path, notice: result.notice
    else
      redirect_to friendship_path, alert: result.errors.full_messages.join(", ")
    end
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end
end
