class Categories::SendWinnerEmailWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'emails',
                  retry: false

  def perform(game_id)
    game = Game.find(game_id)
    game.winners.each do |user|
      tmp_user = User.includes(:transactions).find(user.to_i)
      query_string = "game_id = ? AND amount > 0 AND status IN (3, 4, 5)"
      transaction = tmp_user.transactions.find_by(query_string, game.id)

      GamesMailer.winner(tmp_user, transaction, I18n.t(transaction.status)).deliver_now
    end
  end
end
