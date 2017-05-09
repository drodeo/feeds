class Categories::GenerateWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'categories',
                  retry: false
  def perform
    Games::GenerateGamesService.call
  end
end
