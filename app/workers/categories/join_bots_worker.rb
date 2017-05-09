class Categories::JoinBotsWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'categories',
                  retry: false
  def perform
    Game.active.each do |game|
      Games::BotsJoinService.call(game: game)
    end
  end
end
