class FriendshipsQuery
  def initialize(user, params)
    @user = user
    @status = params[:status]
  end

  def call
    incoming_requests = @user.inverse_friendships.where(status: @status)
    sent_requests = @user.friendships.where(status: @status)

    { incoming_requests: incoming_requests, sent_requests: sent_requests }
  end

  private

  attr_reader :user, :status
end


