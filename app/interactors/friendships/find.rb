module Friendships
  class Find
    include Interactor

    delegate :id, to: :context

    def call
      context.friendship = Friendship.find_by(id: id)
      context.fail!(errors: { base: ["Friendship not found"] }) unless context.friendship
    end
  end
end
