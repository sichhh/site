class AvatarLoadQuery
  def initialize(user, params)
    @user = user
    @avatar = params[:avatar]
    @avatar_url = params[:avatar_url]
  end

  def call
    if avatar
      attach_file
    elsif avatar_url
      attach_from_url
    else
      user.errors.add(:avatar, "No avatar provided")
    end

    OpenStruct.new(success?: user.errors.empty?, errors: user.errors.full_messages)
  end

  private

  attr_reader :user, :avatar, :avatar_url

  def attach_file
    user.avatar.attach(avatar)
  end

  def attach_from_url
    file = open_file(avatar_url)
    user.avatar.attach(io: file, filename: File.basename(URI.parse(avatar_url).path))
  end

  def open_file(url)
    URI.parse(url).open
  end
end
