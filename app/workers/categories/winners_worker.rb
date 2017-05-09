class Categories::WinnersWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'categories',
                  retry: false

  def perform
    Game.active.each do |game|
      winners = Games::WinnerService.call(game: game)
      if winners.present?
        Games::SendWinnerEmailWorker.perform_async(game.id)
        Games::CalculateReferralBonusService.call(game: game)
        Games::CalculateBenefitService.call(game: game)
      end
    end
  end
end
