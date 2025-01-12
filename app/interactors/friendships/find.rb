module Friendships
  class Find
    include Interactor

    delegate :id, to: :context

    def call
      context.friendship = Friendship.find_by(id: id)

      return if context.friendship

      context.fail!(errors: { base: ["Friendship not found"] })
    end
  end
end
